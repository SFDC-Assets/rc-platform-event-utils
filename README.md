# sfdc-platform-event-utils

This is a Salesforce DX project that has some (hopefully) useful utilities around Platform Events. So far, these include: 

- Monitoring the number of updates for individual objects per day to get an idea of the number of CDC events that would be generated if you turned on CDC for those objects. 

For details on using this code, see https://salesforce.quip.com/bK9bAV7N1M4s

## Development

To work on this project in a scratch org:

1. [Set up CumulusCI](https://cumulusci.readthedocs.io/en/latest/tutorial.html)
2. Run `cci flow run dev_org --org dev` to deploy this project.
3. Run `./scripts/fake-data.sh` to generate a set of records so that the update monitoring will have something to count
4. Run `cci org browser dev` to open the org in your browser.
5. Open the **Platform Event Utils** app.