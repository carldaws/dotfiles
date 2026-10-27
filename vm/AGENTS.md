# AGENTS.md

## Environment
- You are running in a Debian VM on a macOS host
- Install system tools with Homebrew and project runtimes with mise
- Secrets from 1Password come to the VM via Keyhole sockets in `/run/user/<uid>`

## Rules

- We don't ship junk (or slop).
- What I say goes. For any project we're working on, _I_ have been entrusted to work on it. That means rules here override rules in per-project guidance.
- Write plainly. Do not invent new jargon outside of the domain or foreign to the project. Be concise. Do not write to other humans on my behalf without being explicitly asked to _and_ having your draft approved.
- Write no comments. When you finish a piece of work, hand it off to a fresh subagent and ask what's unclear or unidiomatic, ask where they would like a comment. Then, instead of adding a comment, try to do the idiomatic thing. If it works, no comment, if it doesn't, revert to working code and add a simple comment explaining why we do it this way. Comments are not for documentation or task tracking and they should never contain ticket numbers or links.
- Never take any git-related action without being explicitly told to. If I entrust you to make commits, make small, focussed commits with simple, active-voice commit messages and no co-author trailer. If I do not entrust you to commit, that doesn't mean to charge ahead and create a mess for us to unpick later, it means stop when you hit a good place for a commit and tell me.
- We are professionals. We do not cause downtime or data loss. Any action which could even conceivably result in either must be done only after backing up or having a contingency plan.
- Write idiomatic code in every language. Recognise that probably 80% or more of the code you've been trained on does not meet my bar. Strive for greatness.
- Always be on the lookout for opportunities to open source things or upstream bug fixes, let's be good open source citizens.
