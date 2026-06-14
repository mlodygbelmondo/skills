---
name: supabase-account-management
description: Manage local Supabase CLI account profiles with the user's `sbsw`, `supabase-profile`, and `supabase-as` helpers. Use when adding a new Supabase account token, switching the active Supabase CLI account, checking which Supabase account is active, preserving existing tokens before login, migrating profiles between machines, or running Supabase commands under named profiles such as `bsplic` and `bussin`.
---

# Supabase Account Management

Use the local Supabase token profile helpers instead of assuming the Supabase CLI is logged into the right account. Treat every profile token as a secret.

## Commands

- `supabase-profile list`: list saved profile names and show the active CLI token status.
- `supabase-profile active`: show whether `~/.supabase/access-token` matches a saved profile.
- `sbsw <profile>`: permanently switch the active Supabase CLI account by copying the saved profile token into `~/.supabase/access-token`.
- `supabase-as <profile> <args...>`: run one Supabase command with a profile token without changing the active account.
- `supabase-profile clear-active`: remove the active token after saving or matching it to an existing profile.
- `supabase-profile capture <profile>`: save the current active login as a named profile, then clear the active token.

The saved profile files live at `~/.supabase/profiles/<profile>/access-token`. Never print their contents, paste them into chat, commit them, or copy them into project files.

## Existing Profile Pattern

On this machine, known examples include:

- `bsplic`: personal/BSPLIC Supabase account profile.
- `bussin`: Bussin project Supabase account profile.

Always verify the current state instead of relying on memory:

```bash
supabase-profile list
supabase-profile active
```

To switch normal Supabase CLI commands to a profile:

```bash
sbsw bussin
pnpm exec supabase projects list
```

To check a profile without changing the active account:

```bash
supabase-as bsplic projects list
supabase-as bussin projects list
```

## Add A New Supabase Account

Use this workflow when the user wants to add another Supabase account, for example `client-x`:

1. Check current state:

```bash
supabase-profile list
supabase-profile active
```

2. Clear the active token before browser login so Supabase does not reuse the old account:

```bash
supabase-profile clear-active
```

3. Start the normal Supabase browser login from the relevant repo:

```bash
pnpm exec supabase login
```

4. Let the user complete the browser login. Do not ask for or print the token.

5. Save the new login as a profile:

```bash
supabase-profile capture client-x
```

6. Verify the new profile without making it active:

```bash
supabase-as client-x projects list
```

7. Permanently switch to it only when the user wants normal `supabase` commands to use that account:

```bash
sbsw client-x
```

## Link A Project With The Right Account

Before `supabase link`, switch to the intended account:

```bash
sbsw bussin
pnpm exec supabase link --project-ref <project-ref>
```

If the user is unsure which account owns the project, inspect projects with `supabase-as <profile> projects list` for each candidate profile.

## Move Profiles To Another Machine

For another Linux or macOS machine:

1. Install or copy the helper commands so `sbsw`, `supabase-profile`, and `supabase-as` exist on `PATH`.
2. Securely copy `~/.supabase/profiles/<profile>/access-token` files to the same path on the new machine.
3. Set restrictive permissions:

```bash
chmod 700 ~/.supabase ~/.supabase/profiles ~/.supabase/profiles/*
chmod 600 ~/.supabase/profiles/*/access-token
```

4. Verify:

```bash
supabase-profile list
supabase-as bussin projects list
```

Do not commit profile files or move them through a repo. Use a private transfer method controlled by the user.

## Safety Rules

- Prefer `supabase-as <profile> ...` for read-only checks because it does not change global CLI state.
- Use `sbsw <profile>` before migrations, links, secrets, deploys, or any command that should persistently target one account.
- Use `supabase-profile clear-active` before asking the user to log into a different account.
- If `supabase-profile active` reports an unsaved active token, save it with `supabase-profile capture <profile>` before clearing unless the user explicitly says to discard it.
- Never run destructive Supabase commands unless the user explicitly requests them and the intended profile is verified.
