-- ═══════════════════════════════════════════════════════
--  WHO VS YOU? eTournament — Supabase Tables Setup
--  Run this ONCE in: Supabase → SQL Editor → New Query
-- ═══════════════════════════════════════════════════════

-- 1. PLAYERS
create table if not exists players (
  id text primary key,
  name text not null,
  photo text default '',
  created_at timestamptz default now()
);

-- 2. GROUPS
create table if not exists groups (
  id text primary key,
  name text not null,
  players text default '[]',
  created_at timestamptz default now()
);

-- 3. FIXTURES (group stage matches)
create table if not exists fixtures (
  id text primary key,
  group_id text,
  round integer default 1,
  home text,
  away text,
  home_score integer,
  away_score integer,
  played boolean default false,
  created_at timestamptz default now()
);

-- 4. KNOCKOUT MATCHES
create table if not exists knockout_matches (
  id text primary key,
  round text,
  match_num integer default 1,
  home text,
  away text,
  home_score integer,
  away_score integer,
  played boolean default false,
  winner text,
  legs integer default 1,
  leg_results text default '[]',
  penalties text,
  created_at timestamptz default now()
);

-- 5. TOURNAMENT (single row, stores full config as JSON)
create table if not exists tournaments (
  id integer primary key default 1,
  data jsonb,
  created_at timestamptz default now()
);

-- 6. MATCH LOG
create table if not exists match_log (
  id text primary key,
  group_name text,
  match_text text,
  score text,
  time text,
  created_at timestamptz default now()
);

-- 7. SEASONS (archived past seasons as JSON)
create table if not exists seasons (
  id text primary key,
  data jsonb,
  created_at timestamptz default now()
);

-- ── Row Level Security (allow public read + anon write) ──
alter table players          enable row level security;
alter table groups           enable row level security;
alter table fixtures         enable row level security;
alter table knockout_matches enable row level security;
alter table tournaments      enable row level security;
alter table match_log        enable row level security;
alter table seasons          enable row level security;

create policy "read all" on players          for select using (true);
create policy "read all" on groups           for select using (true);
create policy "read all" on fixtures         for select using (true);
create policy "read all" on knockout_matches for select using (true);
create policy "read all" on tournaments      for select using (true);
create policy "read all" on match_log        for select using (true);
create policy "read all" on seasons          for select using (true);

create policy "write all" on players          for all using (true) with check (true);
create policy "write all" on groups           for all using (true) with check (true);
create policy "write all" on fixtures         for all using (true) with check (true);
create policy "write all" on knockout_matches for all using (true) with check (true);
create policy "write all" on tournaments      for all using (true) with check (true);
create policy "write all" on match_log        for all using (true) with check (true);
create policy "write all" on seasons          for all using (true) with check (true);
