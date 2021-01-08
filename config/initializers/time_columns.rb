# We don't want to apply timezone info to pure time fields - the only places
# they're used at the moment are game meet and start times, and those should
# always be considered local time.
#
# This overrides the Rails default setting, which is [:time, :datetime].

Rails.application.config.active_record.time_zone_aware_types = [:datetime]