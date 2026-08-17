"""
Streamlit Demo Dashboard
-------------------------
A single-file app that showcases the essential Streamlit concepts:
- Page config & layout (sidebar, columns, tabs, expander)
- Widgets (text input, slider, selectbox, multiselect, checkbox, button)
- Caching (@st.cache_data)
- Session state (persistent counter)
- Forms (batched input submission)
- File upload
- Charts (native + matplotlib)
- Dataframes & metrics

Run with:
    streamlit run dashboard.py
"""

import streamlit as st
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# -----------------------------------------------------------------
# 1. PAGE CONFIG — must be the first Streamlit command in the script
# -----------------------------------------------------------------
st.set_page_config(
    page_title="Streamlit Demo Dashboard",
    page_icon="📊",
    layout="wide",
)

# -----------------------------------------------------------------
# 2. CACHED DATA LOADING — expensive work only runs once
# -----------------------------------------------------------------
@st.cache_data
def load_data():
    np.random.seed(42)
    regions = ["North", "South", "East", "West"]
    products = ["Widget", "Gadget", "Gizmo"]
    rows = []
    for month in pd.date_range("2025-01-01", periods=12, freq="MS"):
        for region in regions:
            for product in products:
                rows.append({
                    "Month": month,
                    "Region": region,
                    "Product": product,
                    "Sales": np.random.randint(500, 5000),
                    "Units": np.random.randint(10, 200),
                })
    return pd.DataFrame(rows)

df = load_data()

# -----------------------------------------------------------------
# 3. SESSION STATE — a value that persists across every rerun
# -----------------------------------------------------------------
if "refresh_count" not in st.session_state:
    st.session_state.refresh_count = 0

def bump_counter():
    st.session_state.refresh_count += 1

# -----------------------------------------------------------------
# 4. SIDEBAR — filters that control the whole dashboard
# -----------------------------------------------------------------
st.sidebar.title("⚙️ Controls")

regions_selected = st.sidebar.multiselect(
    "Region", options=df["Region"].unique(), default=list(df["Region"].unique())
)
products_selected = st.sidebar.multiselect(
    "Product", options=df["Product"].unique(), default=list(df["Product"].unique())
)
min_sales = st.sidebar.slider("Minimum monthly sales ($)", 0, 5000, 0, step=100)

st.sidebar.divider()
st.sidebar.button("🔄 Log a refresh", on_click=bump_counter)
st.sidebar.caption(f"Refreshes logged this session: {st.session_state.refresh_count}")

# Apply filters
filtered = df[
    df["Region"].isin(regions_selected)
    & df["Product"].isin(products_selected)
    & (df["Sales"] >= min_sales)
]

# -----------------------------------------------------------------
# 5. HEADER + METRICS ROW
# -----------------------------------------------------------------
st.title("📊 Streamlit Demo Dashboard")
st.caption("A single-page demo covering the core Streamlit building blocks.")

col1, col2, col3, col4 = st.columns(4)
col1.metric("Total Sales", f"${filtered['Sales'].sum():,}")
col2.metric("Total Units", f"{filtered['Units'].sum():,}")
col3.metric("Avg Order Value", f"${filtered['Sales'].mean():,.0f}" if len(filtered) else "$0")
col4.metric("Rows Shown", f"{len(filtered):,}")

st.divider()

# -----------------------------------------------------------------
# 6. TABS — organize different views of the data
# -----------------------------------------------------------------
tab_overview, tab_charts, tab_data, tab_upload, tab_feedback = st.tabs(
    ["Overview", "Charts", "Raw Data", "Upload Your Own", "Feedback Form"]
)

# --- Overview tab -------------------------------------------------
with tab_overview:
    st.subheader("Sales by Region")
    region_summary = filtered.groupby("Region")["Sales"].sum().sort_values(ascending=False)
    st.bar_chart(region_summary)

    with st.expander("What am I looking at?"):
        st.write(
            "This chart aggregates the filtered dataset by region. "
            "Use the sidebar to change which regions, products, and minimum "
            "sales threshold are included — the whole dashboard updates instantly "
            "because Streamlit reruns the script on every widget change."
        )

# --- Charts tab -----------------------------------------------------
with tab_charts:
    st.subheader("Monthly Trend")
    monthly = filtered.groupby("Month")["Sales"].sum()
    st.line_chart(monthly)

    st.subheader("Sales Distribution (Matplotlib)")
    fig, ax = plt.subplots()
    ax.hist(filtered["Sales"], bins=20, color="#FF4B4B", edgecolor="white")
    ax.set_xlabel("Sales ($)")
    ax.set_ylabel("Frequency")
    st.pyplot(fig)

# --- Raw Data tab ---------------------------------------------------
with tab_data:
    st.subheader("Filtered Dataset")
    st.dataframe(filtered.sort_values("Month"), use_container_width=True)
    st.download_button(
        "Download filtered data as CSV",
        data=filtered.to_csv(index=False).encode("utf-8"),
        file_name="filtered_sales.csv",
        mime="text/csv",
    )

# --- Upload tab -------------------------------------------------------
with tab_upload:
    st.subheader("Try It With Your Own CSV")
    uploaded_file = st.file_uploader("Upload a CSV file", type=["csv"])
    if uploaded_file is not None:
        user_df = pd.read_csv(uploaded_file)
        st.success(f"Loaded {len(user_df)} rows, {len(user_df.columns)} columns.")
        st.dataframe(user_df.head(20), use_container_width=True)

        numeric_cols = user_df.select_dtypes(include="number").columns.tolist()
        if numeric_cols:
            col_to_plot = st.selectbox("Pick a numeric column to chart", numeric_cols)
            st.line_chart(user_df[col_to_plot])
    else:
        st.info("Upload a CSV to preview it here.")

# --- Feedback form tab -------------------------------------------------
with tab_feedback:
    st.subheader("Send Feedback")
    st.write("Forms batch input together — nothing reruns until you hit Submit.")
    with st.form("feedback_form", clear_on_submit=True):
        name = st.text_input("Name")
        rating = st.select_slider("How was your experience?", options=["😞", "🙁", "😐", "🙂", "😄"], value="😐")
        comments = st.text_area("Comments")
        agree = st.checkbox("I'm okay being contacted about this feedback")
        submitted = st.form_submit_button("Submit Feedback")

    if submitted:
        st.success(f"Thanks, {name or 'anonymous user'}! Rating received: {rating}")
        if comments:
            st.write("Your comments:")
            st.info(comments)

# -----------------------------------------------------------------
# 7. FOOTER
# -----------------------------------------------------------------
st.divider()
st.caption("Built with Streamlit — demonstrates caching, session state, forms, tabs, columns, sidebar, charts, and file upload in one app.")