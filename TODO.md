# TODO

- [ ] Step 1: Update `frontend/lib/core/api/insight_api.dart` to add the 4 new methods.
- [ ] Step 2: Create missing model files under `frontend/lib/features/insights/models/`:
  - [ ] category_data.dart
  - [ ] goal_report_data.dart
  - [ ] health_score_data.dart
  - [ ] trend_data.dart
- [ ] Step 3: Update `frontend/lib/features/insights/screens/insight_screen.dart`:
  - [ ] Add futures for the 4 endpoints.
  - [ ] In `initState()`, assign them (month hardcoded to "June").
  - [ ] Insert 4 cards under the existing Savings card using `FutureBuilder` + the new models.
- [ ] Step 4: Ensure imports are correct and types match the UI builders.
- [ ] Step 5: Run Flutter analyze/build (if available) to verify compilation.

