# Step 04 Create Labeled Dataset for Churn Analysis
# Author: Andrew Macumber
# Pre-requisites: Step 01, Step 02, Step 03

#
## Rationale
# We are interested in Y1_Limiteds that become Y2_Ideals (engaged) and will compare them to
# Y1_Limiteds who become Y2_Limiteds (static).
##
#

#
## Create Labeled Dataset
labeled_filter <- member_engagement_levels %>%
  
  # Only Y1_Limited that are at least Y2_Limited
  filter(Y1 == 'Limited (<1)', Y2 != 'Absent') %>%
  
  # Label the dataset
  mutate(
    label = ifelse(Y2 == 'Limited (<1)', 'static', 'engaged')) %>%
  
  # Select only member ID and label column
  select(d4g_member_id, label) %>%
  
  # Add Year 1 column
  left_join(Member_Year1, by = "d4g_member_id") %>%
  
  # Remove duplicate column
  select(-first_year_checked_in) %>%
  
  # Add member info dimensions
  left_join(member_df, by = "d4g_member_id") %>%
  
  # Create Y1_Age dimension
  mutate(
    Y1_Age = first_year - birth_year
  )
##
#