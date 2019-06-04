# Worktimizer
Hackathon 2019

# Main Feature
For each employee, read email, fetch recent emails and classify their importance. Give the busy-ness score for each employee and show their scores in one place in another tab.

# Work Flow

1. Email Data preparation - used public enron email data fetched online

  * 1 Coarse genre
    * 1.1 **Company Business, Strategy, etc. (elaborate in Section 3 [Topics]) (855 cnt.)**
    * 1.2 Purely Personal (49 cnt.)
    * 1.3 Personal but in professional context (e.g., it was good working with you) (165 cnt.)
    * 1.4 Logistic Arrangements (meeting scheduling, technical support, etc) (533 cnt.)
    * 1.5 **Employment arrangements (job seeking, hiring, recommendations, etc) (96 cnt.)**
    * 1.6 **Document editing/checking (collaboration) (176 cnt.)**
    * 1.7 Empty message (due to missing attachment) (25 cnt.)
    * 1.8 Empty message (26 cnt.)


2. Model learning - Apple's CoreML NLP classifier model to do sentiment analysis

3. Build app to do login, fetch email, run classification using predefined model, and show the result.
