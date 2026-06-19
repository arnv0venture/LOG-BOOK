-- ============================================
-- LOG BOOK — Supabase Database Setup
-- Run this in the Supabase SQL Editor
-- ============================================

-- expenses table
CREATE TABLE IF NOT EXISTS expenses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  amount NUMERIC NOT NULL CHECK (amount > 0),
  category TEXT NOT NULL DEFAULT 'Other',
  note TEXT,
  logged_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  entry_date DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE INDEX IF NOT EXISTS idx_expenses_entry_date ON expenses(entry_date DESC);
CREATE INDEX IF NOT EXISTS idx_expenses_category ON expenses(category);

-- income table
CREATE TABLE IF NOT EXISTS income (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  amount NUMERIC NOT NULL CHECK (amount > 0),
  source_label TEXT,
  logged_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  entry_date DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE INDEX IF NOT EXISTS idx_income_entry_date ON income(entry_date DESC);

-- ============================================
-- Row Level Security
-- Option A: Disable RLS (simplest for personal app)
-- ============================================
ALTER TABLE expenses ENABLE ROW LEVEL SECURITY;
CREATE POLICY "allow_all_expenses" ON expenses FOR ALL USING (true) WITH CHECK (true);

ALTER TABLE income ENABLE ROW LEVEL SECURITY;
CREATE POLICY "allow_all_income" ON income FOR ALL USING (true) WITH CHECK (true);

-- ============================================
-- If you prefer to fully disable RLS instead:
-- ALTER TABLE expenses DISABLE ROW LEVEL SECURITY;
-- ALTER TABLE income DISABLE ROW LEVEL SECURITY;
-- ============================================
