use Mix.Config

config :opencensus,
  sampler: {:oc_sampler_always, []},
  reporters: [{:oc_reporter_zipkin, []}]
