# Resume Bullet Points

Pick 2–4 of these, adapt the numbers to what you actually built (don't
inflate — if you used the default 8,000 orders, say 8,000; interviewers may
ask about your data), and tailor the wording to match the job posting's
language.

## Project title options
- **Retail Sales Analytics Dashboard** (Python, SQL, Metabase)
- **End-to-End Data Analytics Pipeline: Data Cleaning → SQL Analysis → BI Dashboard**

## Bullet points

- Built an end-to-end analytics pipeline processing 8,000+ e-commerce
  transactions, using **Python (pandas)** to clean and validate raw data
  (handling missing values, duplicates, and formatting inconsistencies)
  before loading into a **PostgreSQL** database.

- Designed a **PostgreSQL** relational schema (3 tables, foreign keys,
  indexes) and wrote **8 SQL queries** — including window functions
  (`LAG`, `NTILE`) and CTEs — to answer business questions on revenue
  trends, product performance, and customer behavior.

- Performed **RFM (Recency, Frequency, Monetary) customer segmentation**
  using SQL window functions to classify customers into actionable
  segments (Champions, At Risk, Lost), simulating a real retention-
  analysis use case.

- Built an interactive **Metabase** dashboard with 6+ visualizations
  (revenue trends, category breakdowns, customer segments) and date
  filtering, translating raw SQL output into a stakeholder-ready BI tool.

- Conducted exploratory data analysis in Python (**pandas, matplotlib**)
  to identify revenue trends, a 6.5% return rate, and regional
  performance gaps, presenting findings through visual charts.

## One-line project summary (for a "Projects" section header)

> Retail Sales Analytics — Built a full analytics pipeline (Python data
> cleaning, PostgreSQL/SQL analysis, Metabase dashboard) on an 8,000-row
> e-commerce dataset; includes RFM customer segmentation and an interactive
> BI dashboard. [GitHub link]

## If asked in an interview: "Walk me through this project"

A strong 60-second answer, in order:
1. **The problem**: "I wanted to show the full analyst workflow — not just
   a Jupyter notebook — from messy raw data to a dashboard a stakeholder
   could actually use."
2. **Cleaning**: "The raw data had missing quantities, inconsistent
   casing, and duplicate rows. I imputed missing quantities using the
   per-product median rather than dropping rows, since dropping would
   lose real revenue signal."
3. **SQL**: "I moved the clean data into PostgreSQL and wrote queries
   ranging from basic aggregation up to an RFM segmentation using window
   functions — that's the query I'm most proud of."
4. **Dashboard**: "I connected Metabase to the database and built an
   interactive dashboard with a date filter so a manager could self-serve
   answers instead of asking me for a new query every time."
5. **What I'd do next**: mention one item from the "Extending this
   project" section of the README — shows you think beyond the assignment.
