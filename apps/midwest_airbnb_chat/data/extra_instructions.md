# Extra Instructions

Rules the LLM follows when it writes SQL for `listings`.

- `price` is the nightly price in U.S. dollars. When the user asks what something costs, use `price` and round money to whole dollars in the answer.
-`host_is_superhost` and `instant_bookable` use `t` for true and `f` for false. Use these values when filtering for Superhosts or instantly bookable listings.
- When calculating an average rating, leave out listings where `review_scores_rating` is NULL.
