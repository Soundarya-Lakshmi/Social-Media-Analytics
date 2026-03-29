# Social Media Analytics using Snowflake (JSON Processing)

## 📌 Overview
This project analyzes semi-structured Twitter data to understand hashtag usage, user engagement, and content sharing patterns using Snowflake and SQL.

---

## 🎯 Objective
To process nested JSON data and derive meaningful insights on how users interact with hashtags and URLs in social media content.

---

## 🛠️ Tech Stack
- **Snowflake** (VARIANT, LATERAL FLATTEN, Views)
- **SQL**
- **Snowsight Dashboard**

---

## ⚙️ Data Processing Steps
- Ingested raw JSON tweet data into Snowflake using VARIANT data type  
- Parsed nested fields using Snowflake’s `:` operator  
- Applied **LATERAL FLATTEN** to normalize hashtags and URLs  
- Created structured views for analysis (`hashtags_normalized`, `urls_normalized`)  
- Performed aggregations to analyze user activity and content behavior  

---

## 📊 Dashboard Highlights
- **Unique Hashtags (KPI)** – Total distinct hashtags used  
- **Average Hashtags per Tweet** – Measures tagging intensity  
- **User Engagement via Hashtag Usage** – Identifies active users  
- **Content Sharing Patterns (URL Frequency)** – Tracks most shared links  
- **Hashtag vs No Hashtag** – Analyzes content strategy  
- **URL vs No URL** – Measures external content sharing behavior  
- **Hashtag Usage Over Time** – Tracks activity trends  

---

## 🔍 Key Insights 
- Certain URLs are shared multiple times, indicating popular content  
- Variation in hashtag usage highlights different engagement behaviors  
- External link sharing is a common pattern in tweet content  

---

## 📁 Repository Structure
