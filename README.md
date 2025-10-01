# EurOmnis 2025 Sessions
This reposity contains all the materials for my 2025 EurOmnis sessions:
 * Extending PostgreSQL
 * Software Testing Clinic

Feel free to download and adapt this material to your needs.


## Extending PostgreSQL

### Running

1. Install docker
1. Clone this repo
1. `cd` into `extending-postgresql`
1. Run `docker compose --build up --detach`

### Stopping

1. `cd` into `extending-postgresql`
1. Run docker compose down

### Connecting to PostgreSQL

```
docker exec -it euromnis-2025-extending-postgresql psql -U postgres -d euromnis_demo
```

### HTTP Examples

Get my IP:

```
select content::jsonb -> 'ip' from http.http_get('https://api.ipify.org?format=json');
```

Get current exchange rate (please use your own API key for https://freecurrencyapi.com/):
```
select content from http.http_get('https://api.freecurrencyapi.com/v1/latest', '{"apikey": "fca_live_ZWDcNzthuVy2mBcxk9ZY6SPgZBqlExZw2rG6w64p", "currencies": "EUR,USD,GBP"}');
```