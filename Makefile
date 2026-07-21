SHELL := /bin/sh

.PHONY: help init codex-skills

help:
	@printf '%s\n' \
		'Available targets:' \
		'  make init       Prepare repo-local Codex skills and validate the package.' \

init: codex-skills
	@printf '\n%s\n\n' 'Codex client bootstrap:'
	@./orchestrator init-client
	@printf '\n%s\n' 'Ready. Restart Codex or start a new Codex session if these skills were not already visible.'

codex-skills:
	@set -eu; \
	mkdir -p .agents; \
	if [ -e .agents/skills ] && [ ! -L .agents/skills ]; then \
		printf '%s\n' 'error: .agents/skills exists and is not a symlink; move it aside before bootstrapping.' >&2; \
		exit 1; \
	fi; \
	if [ -L .agents/skills ]; then \
		target=$$(readlink .agents/skills); \
		if [ "$$target" != "../skills" ]; then \
			printf 'error: .agents/skills points to %s, expected ../skills\n' "$$target" >&2; \
			exit 1; \
		fi; \
	else \
		ln -s ../skills .agents/skills; \
	fi; \
	for skill in skills/*/SKILL.md; do \
		awk 'NR == 1 { exit ($$0 == "---" ? 0 : 1) }' "$$skill" || { \
			printf 'error: missing Codex skill frontmatter in %s\n' "$$skill" >&2; \
			exit 1; \
		}; \
		awk 'NR == 1 && $$0 != "---" { exit 1 } NR > 1 && $$0 == "---" { found=1; exit 0 } END { exit found ? 0 : 1 }' "$$skill" || { \
			printf 'error: incomplete Codex skill frontmatter in %s\n' "$$skill" >&2; \
			exit 1; \
		}; \
		awk 'NR == 1 && $$0 == "---" { in_meta=1; next } in_meta && $$0 == "---" { exit (name && description ? 0 : 1) } in_meta && $$1 == "name:" { name=1 } in_meta && $$1 == "description:" { description=1 } END { exit (name && description ? 0 : 1) }' "$$skill" || { \
			printf 'error: Codex skill frontmatter must include name and description in %s\n' "$$skill" >&2; \
			exit 1; \
		}; \
	done; \
	printf '%s\n' 'Codex repo skills linked at .agents/skills.'
