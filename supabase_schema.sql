-- À exécuter une seule fois dans Supabase : Project > SQL Editor > New query > Run

create table if not exists app_state (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);

-- Active la sécurité par ligne (obligatoire sur Supabase) puis autorise
-- explicitement l'accès libre en lecture/écriture, puisque l'outil est
-- volontairement ouvert à tous ceux qui ont le lien (pas de compte).
alter table app_state enable row level security;

create policy "lecture publique" on app_state
  for select using (true);

create policy "ecriture publique (insert)" on app_state
  for insert with check (true);

create policy "ecriture publique (update)" on app_state
  for update using (true);
