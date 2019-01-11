# PCF Dashboards
_*These serve as examples. This work should be duplicated and manipulated by the customer. This work was originally published by Pivotal at https://github.com/pivotal-cf/metrics-datadog-dashboard -- this repo has deviated from the original intent and thus is not a fork*_

These are examples of Datadog Dashboards for PCF environments using the metrics coming through the Datadog firehose nozzle. These are only a small subset of those OOTB Dashboards offered by Datadog. The original effort comes from Pivotal themselves at https://github.com/pivotal-cf/metrics-datadog-dashboard (of which this was originally a fork, but we've diverted fairly far from the original intent) -- we encourage teams to also look at PCF's CloudOps team Datadog dashboard collection at https://github.com/pivotal-cf-experimental/datadog-config-oss/.

To get a JSON representation of an existing screenboard, run `ruby get_screenboard [screenboard_id]` or `ruby get_all_screenboards` if you don't know the screenboard_id.

To get a JSON representation of an existing timeboard, run `ruby get_timeboard [timeboard_id]`.

# Noteworthy
It is worth noting that the metrics emitted by Cloud Foundry and those collected natively by the Datadog agent through out of the box integrations do not always align. These dashboards serve as examples and are primarily carved from either existing PCF work or the out of the box Datadog dashboards that have been converted to use the Cloud Foundry nozzle metrics. 

In some cases certain metrics were not emitted from the CF firehose and therefore graphs or components were dropped and in some cases conversions were made. These dashboards should serve as examples and starting points and be expanded upon by the team implementing them. Cloud foundry is rich in metrics and only small subsets are being exposed via these dashboards.

Additionally, all of these dashboards use to the default CF nozzle prefix: `cloudfoundry.nozzle.*` and this repo could benefit from templating to support a custom prefix. If you use a custom prefix you will need to replace `cloudfoundry.nozzle.*` with your own namespace.

# CF RabbitMQ
The metrics collected by the agent based [Datadog Integration](https://docs.datadoghq.com/integrations/rabbitmq/#data-collected) and [those emitted via the Firehose by Cloud Foundry](https://docs.pivotal.io/rabbitmq-cf/1-11/monitor.html#rabbitmq-metrics) are fairly different, though they do share a number core metrics. Primarily there are more metrics via the Datadog integration.

The KPIs from [Cloud Foundry](https://docs.pivotal.io/rabbitmq-cf/1-11/monitor.html#server-kpis) and those from [Datadog](https://www.datadoghq.com/blog/rabbitmq-monitoring/#key-rabbitmq-metrics) vary somewhat as well. However both of these resources can be used as a basis for expanding on the Rabbit MQ dashboard examples below.

The Dashboards below are converted Datadog out of the box Rabbit MQ Dashboards that come with the agent based integration that now leverage the cloud foundry namespace metrics (defaults to `cloudfoundry.nozzle.*`). They can be manipulated via the UI w/ new KPIs, graphs, and widgets to best suite the team(s) using them.

## Example screenboard
To push to Datadog:
1. Set your DATADOG_APP_KEY and DATADOG_API_KEY in your environment (you can find them under Integrations > APIs)

    ```
    export DATADOG_API_KEY=theapikey
    export DATADOG_APP_KEY=theappkey
    ```

1. Run `ruby import_static_screenboard [FILENAME]`, passing in the name of the file that contains your dashboard configuration. See `dashboards/rabbitmq.json` for an example.

## Example timeboard
To push to Datadog:
1. Set your DATADOG_APP_KEY and DATADOG_API_KEY in your environment (you can find them under Integrations > APIs)

    ```
    export DATADOG_API_KEY=theapikey
    export DATADOG_APP_KEY=theappkey
    ```

1. Run `ruby import_static_timeboard [FILENAME] <title> <description>`, passing in the name of the file that contains your dashboard configuration. See `dashboards/rmq_timeboard.json` for an example.

# CF Redis example screenboard
To psuh to Datadog:
1. Set your DATADOG_APP_KEY and DATADOG_API_KEY in your environment (you can find them under Integrations > APIs)

    ```
    export DATADOG_API_KEY=theapikey
    export DATADOG_APP_KEY=theappkey
    ```

1. Replace occurrences of `<< MetricPrefix >>` with the `MetricPrefix` defined in your [firehose nozzle config](https://github.com/cloudfoundry-incubator/datadog-firehose-nozzle).
  1. _Chris Kelner: This has been done and committed to this repo; using the default prefix `cloudfoundry.nozzle.*`; this information was retained for posterity_
1. Run `ruby import_static_screenboard [FILENAME]`, passing in the name of the file that contains your dashboard configuration. See `dashboards/redis.json` for an example.

# CF Mysql example timeboard
To push to Datadog:
1. Edit `config/mysql_dashboard.yml` with:
  - MySQL VM guids, ie. `628fd3ea-bd68-43fb-9ac7-e6dc68523f87`
  - MySQL deployment name, ie. `p-mysql`
  - Nozzle name, ie. `datadog.nozzle`
1. Set your DATADOG_APP_KEY and DATADOG_API_KEY in your environment (you can find them under Integrations > APIs)

    ```
    export DATADOG_API_KEY=theapikey
    export DATADOG_APP_KEY=theappkey
    ```
1. Run `gem install dogapi erubis`
1. Run `ruby import_mysql_dashboard`

# CF BOSH System Metrics Dashboard
Taken from the [Pivotal CloudOps team repository](https://github.com/pivotal-cf-experimental/datadog-config-oss/blob/master/dashboard_templates/shared/bosh_system_metrics.json.erb)

This is a hardcoded example for `wtcdev2` - but should leverage similar pattern
to the MySQL example for reusability.

1. Set your DATADOG_APP_KEY and DATADOG_API_KEY in your environment (you can find them under Integrations > APIs)

    ```
    export DATADOG_API_KEY=theapikey
    export DATADOG_APP_KEY=theappkey
    ```
1. Run `ruby import_static_timeboard dashboards/bosh_system_metrics.json`
