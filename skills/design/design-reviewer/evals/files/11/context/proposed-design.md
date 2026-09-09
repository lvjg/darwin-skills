# Travel-policy assistant proposal

Employees currently search the policy portal and ask HR to interpret the results. Add a chat assistant to the portal so employees can describe a trip in their own words and receive guidance in one place.

## Request handling

Pass the employee message to the catalog reader and include the returned policy records in the model context. The system prompt will say: "Understand the employee's intent, use the current catalog, and provide safe, helpful policy guidance in plain language."

Include these examples in the prompt:

- Employee: "I'm employed in Germany and planning a domestic business trip." Assistant: "The Germany domestic-travel policy applies. Economy rail is covered; submit your booking through the travel portal."
- Employee: "I'm employed in Singapore and planning an international business trip." Assistant: "The Singapore international-travel policy applies. Check the destination's allowance table before booking and submit your travel request through the portal."

The model will generalize from these examples to other employee messages. Stream the answer into the existing chat panel and retain the conversation so the employee can follow up.

## Release check

HR will run the two example questions and rate whether each answer is fluent, helpful and consistent with the policy text. Release when both answers are satisfactory. The portal team will then implement the prompt and catalog integration.
