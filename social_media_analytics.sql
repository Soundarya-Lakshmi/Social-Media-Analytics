-- Creating database, table and file format
CREATE DATABASE Social_Media_Floodgates;

CREATE OR REPLACE TABLE TWEET_INGEST (
RAW_STATUS VARIANT);

create file format social_media_floodgates.public.json_file_format
type = 'JSON' 
compression = 'AUTO' 
enable_octal = FALSE
allow_duplicate = TRUE 
strip_outer_array = TRUE
strip_null_values = FALSE 
ignore_utf8_errors = FALSE; 

COPY INTO TWEET_INGEST
FROM @util_db.public.my_internal_stage/nutrition_tweets.json
file_format = (format_name=social_media_floodgates.public.json_file_format);

-- Exploration
select raw_status
from tweet_ingest;


select raw_status:entities
from tweet_ingest;

select raw_status:entities:hashtags
from tweet_ingest;

select raw_status:entities:hashtags[0].text
from tweet_ingest;

select raw_status:entities:hashtags[0].text
from tweet_ingest
where raw_status:entities:hashtags[0].text is not null;


-- Changing data types
select raw_status:created_at::date
from tweet_ingest
order by raw_status:created_at::date;

-- Flattening URLs
select value
from tweet_ingest
,lateral flatten
(input => raw_status:entities:urls);


SELECT value:indices FROM tweet_ingest, lateral flatten(input => raw_status:entities:urls);
SELECT index_value.value FROM tweet_ingest, lateral flatten(input => raw_status:entities:urls) urls,
lateral flatten(input => urls.value:indices) index_value;

select value:display_url
from tweet_ingest
,lateral flatten
(input => raw_status:entities:urls);


-- Flatten and return just the hashtag text, CAST the text as VARCHAR
select value:text::varchar as hashtag_used
from tweet_ingest
,lateral flatten
(input => raw_status:entities:hashtags);

-- Add the Tweet ID and User ID to the returned table 
select raw_status:user:name::text as user_name
,raw_status:id as tweet_id
,value:text::varchar as hashtag_used
from tweet_ingest
,lateral flatten
(input => raw_status:entities:hashtags);

-- Creating views
create or replace view social_media_floodgates.public.urls_normalized as
(select raw_status:user:name::text as user_name
,raw_status:id as tweet_id
,value:display_url::text as url_used
from tweet_ingest
,lateral flatten
(input => raw_status:entities:urls)
);

SELECT * FROM social_media_floodgates.public.urls_normalized;

create or replace view social_media_floodgates.public.hashtags_normalized as
(select raw_status:user:name::text as user_name
,raw_status:id as tweet_id
,value:text::text as hashtags_used
from tweet_ingest
,lateral flatten
(input => raw_status:entities:hashtags)
);

SELECT * FROM social_media_floodgates.public.hashtags_normalized;

