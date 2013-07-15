" Vim syntax file

" Setup
if version >= 600
  if exists("b:current_syntax")
    finish
  endif
else
  syntax clear
endif

" Steffen: let's base on HTML
" This is similar to 'set syntax=html' but doesn't change the
"     name of the syntax
source $VIMRUNTIME/syntax/dosini.vim

" shut case off
syn case ignore

syn match  nomadiniLabel   "^.\{-}="
syn region nomadiniHeader  start="^\[" end="\]"
" Nomad comments with "#" instead of ";", and this can be anywhere in line
" original (from nomadini.vim): syn match nomadiniComment "^;.*$"
syn match   nomadiniComment "#.*$"
syn keyword nomadiniKeyword none error warning notice info verbose crazy
syn keyword nomadiniKeyword TCP IP UDP ICMP
syn match   nomadiniRange    "\<\d\+\(-\d\+\)\?\>"
" approx:
syn match   nomadiniAddress "\(\d\{1,3}\.\)\{3}\d\{1,3}\(:\d\{1,5}\)\?"
syn match   nomadiniHostPort "\<\(\a[0-9A-Za-z-]+\.\?\)\+:\d\{1,5}\>"

" find . -iname '*.ini' | xargs \
"   perl -n -e '/^#(\w+)=/ && print "syn keyword nomadiniParameter $1\n"' \
"   | sort | uniq
syn keyword nomadiniParameter activate
syn keyword nomadiniParameter additional_overhead_per_ip_packet_bytes
syn keyword nomadiniParameter additional_overhead_per_ip_packet_percent
syn keyword nomadiniParameter alias_name
syn keyword nomadiniParameter alive_check_interval
syn keyword nomadiniParameter alive_message_destination_address
syn keyword nomadiniParameter alive_message_interval
syn keyword nomadiniParameter alive_message_local_address
syn keyword nomadiniParameter alive_message_timeout
syn keyword nomadiniParameter apply_loss_simulation
syn keyword nomadiniParameter association_extension_period
syn keyword nomadiniParameter association_persistent_mode
syn keyword nomadiniParameter association_restart_interval
syn keyword nomadiniParameter bandwidth_administration_address
syn keyword nomadiniParameter bandwidth_decrease_containment_absolute_undoc
syn keyword nomadiniParameter bandwidth_decrease_containment_percent_undoc
syn keyword nomadiniParameter bandwidth_drop_algorithm
syn keyword nomadiniParameter bandwidth_increase_containment_absolute_undoc
syn keyword nomadiniParameter bandwidth_increase_containment_percent_undoc
syn keyword nomadiniParameter bandwidth_max_queueing_buffer
syn keyword nomadiniParameter bandwidth_proposition
syn keyword nomadiniParameter bandwidth_proposition_time
syn keyword nomadiniParameter best_effort_weight
syn keyword nomadiniParameter bypass
syn keyword nomadiniParameter capturing_ip_address
syn keyword nomadiniParameter capturing_local_outgoing
syn keyword nomadiniParameter chaining_timeout
syn keyword nomadiniParameter cleanup_stale_timeout
syn keyword nomadiniParameter compression_level
syn keyword nomadiniParameter compression_level_undoc
syn keyword nomadiniParameter compression_mem_level_undoc
syn keyword nomadiniParameter compression_window_bits_undoc
syn keyword nomadiniParameter compress_port_range
syn keyword nomadiniParameter congestion_fast_increase_1_count_undoc
syn keyword nomadiniParameter congestion_fast_increase_1_percent_undoc
syn keyword nomadiniParameter congestion_fast_increase_2_count_undoc
syn keyword nomadiniParameter congestion_fast_increase_2_percent_undoc
syn keyword nomadiniParameter congestion_fast_increase_3_count_undoc
syn keyword nomadiniParameter congestion_fast_increase_3_percent_undoc
syn keyword nomadiniParameter congestion_increase_percent_undoc
syn keyword nomadiniParameter congestion_max_loss_percent_increase
syn keyword nomadiniParameter congestion_max_loss_percent_increase_undoc
syn keyword nomadiniParameter congestion_target_rtt_consider_rtt_d_percent_undoc
syn keyword nomadiniParameter congestion_target_rtt_range
syn keyword nomadiniParameter congestion_use_less_margin_percent_undoc
syn keyword nomadiniParameter connect_address
syn keyword nomadiniParameter considered_http_port
syn keyword nomadiniParameter content_type
syn keyword nomadiniParameter dbg_module_undoc
syn keyword nomadiniParameter default_peer_class
syn keyword nomadiniParameter delay
syn keyword nomadiniParameter dest_ip_range
syn keyword nomadiniParameter dest_ip_range_not
syn keyword nomadiniParameter dest_port_range
syn keyword nomadiniParameter dest_port_range_not
syn keyword nomadiniParameter device
syn keyword nomadiniParameter direction
syn keyword nomadiniParameter disruption_data_receive_interval
syn keyword nomadiniParameter disruption_data_receive_stop
syn keyword nomadiniParameter disruption_dns_address_range
syn keyword nomadiniParameter disruption_dns_answers
syn keyword nomadiniParameter disruption_retry_interval_slow_1_count_undoc
syn keyword nomadiniParameter disruption_retry_interval_slow_1_undoc
syn keyword nomadiniParameter disruption_retry_interval_slow_2_count_undoc
syn keyword nomadiniParameter disruption_retry_interval_slow_2_undoc
syn keyword nomadiniParameter disruption_retry_interval_undoc
syn keyword nomadiniParameter dns_prefetching_embedded_maximum_undoc
syn keyword nomadiniParameter dns_prefetching_links_maximum_undoc
syn keyword nomadiniParameter dns_prefetching_undoc
syn keyword nomadiniParameter dp_basic_activate
syn keyword nomadiniParameter duration_loss
syn keyword nomadiniParameter duration_lossless
syn keyword nomadiniParameter duration_packet_trigger
syn keyword nomadiniParameter end_to_end_connection_setup
syn keyword nomadiniParameter enhancement_protocol
syn keyword nomadiniParameter exclude_url
syn keyword nomadiniParameter execute_dependency
syn keyword nomadiniParameter execute_dependency_check_intervall_undoc
syn keyword nomadiniParameter execute_program
syn keyword nomadiniParameter expect_ack_timeout
syn keyword nomadiniParameter external_peer_traffic_turnarround
syn keyword nomadiniParameter fallback_compression_percent
syn keyword nomadiniParameter forward_apply_loss_simulation
syn keyword nomadiniParameter forward_delay
syn keyword nomadiniParameter forward_interface
syn keyword nomadiniParameter forward_max_bandwidth
syn keyword nomadiniParameter forward_unmatched
syn keyword nomadiniParameter framing_protocol
syn keyword nomadiniParameter gateway_address
syn keyword nomadiniParameter group_name
syn keyword nomadiniParameter guaranteed_bandwidth
syn keyword nomadiniParameter here_ip_range
syn keyword nomadiniParameter here_ip_range_not
syn keyword nomadiniParameter here_port_range
syn keyword nomadiniParameter here_port_range_not
syn keyword nomadiniParameter http_header_compression
syn keyword nomadiniParameter http_object_compression
syn keyword nomadiniParameter http_proxy_access
syn keyword nomadiniParameter initial_bandwidth
syn keyword nomadiniParameter initial_data_rate
syn keyword nomadiniParameter ip_protocol
syn keyword nomadiniParameter ip_protocol_not
syn keyword nomadiniParameter ip_range
syn keyword nomadiniParameter layer
syn keyword nomadiniParameter level
syn keyword nomadiniParameter local_address
syn keyword nomadiniParameter local_tos_range
syn keyword nomadiniParameter log_file
syn keyword nomadiniParameter log_file_size
syn keyword nomadiniParameter loss_algorithm
syn keyword nomadiniParameter loss_percent
syn keyword nomadiniParameter loss_sequence
syn keyword nomadiniParameter loss_simulation_name
syn keyword nomadiniParameter loss_unit
syn keyword nomadiniParameter mac_address_bit_flipping
syn keyword nomadiniParameter max_aggregation_delay
syn keyword nomadiniParameter max_bandwidth
syn keyword nomadiniParameter maximum_bandwidth
syn keyword nomadiniParameter maximum_memory_usage
syn keyword nomadiniParameter maximum_parse_length_undoc
syn keyword nomadiniParameter monitoring_address
syn keyword nomadiniParameter mtu_size
syn keyword nomadiniParameter name
syn keyword nomadiniParameter number_of_log_files
syn keyword nomadiniParameter number_of_processes
syn keyword nomadiniParameter option
syn keyword nomadiniParameter parent_policy_group
syn keyword nomadiniParameter peak_overuse_bandwidth_percent
syn keyword nomadiniParameter peak_overuse_bytes
syn keyword nomadiniParameter peer_class
syn keyword nomadiniParameter peer_communication_original_ip_addresses
syn keyword nomadiniParameter peer_communication_port_offset
syn keyword nomadiniParameter peer_communication_tos
syn keyword nomadiniParameter peer_communication_tos_range
syn keyword nomadiniParameter peer_device
syn keyword nomadiniParameter peer_password
syn keyword nomadiniParameter policy_group
syn keyword nomadiniParameter policy_matching_order
syn keyword nomadiniParameter policy_name
syn keyword nomadiniParameter protocol
syn keyword nomadiniParameter protocol_not
syn keyword nomadiniParameter qos_class
syn keyword nomadiniParameter qos_policy_type
syn keyword nomadiniParameter qos_weight
syn keyword nomadiniParameter queueing_buffer_max
syn keyword nomadiniParameter queueing_buffer_min
syn keyword nomadiniParameter queueing_delay_max
syn keyword nomadiniParameter raw_passthrough_device
syn keyword nomadiniParameter reconnect_interval
syn keyword nomadiniParameter recording_file
syn keyword nomadiniParameter recording_file_size
syn keyword nomadiniParameter recording_files_shift_maximum
syn keyword nomadiniParameter recording_interim_record_interval
syn keyword nomadiniParameter recording_interval
syn keyword nomadiniParameter recording_level
syn keyword nomadiniParameter recording_shift_execute_program
syn keyword nomadiniParameter recording_shift_time
syn keyword nomadiniParameter redundancy_status_execute_program
syn keyword nomadiniParameter remote_address
syn keyword nomadiniParameter restore_original_ip_addresses
syn keyword nomadiniParameter return_apply_loss_simulation
syn keyword nomadiniParameter return_delay
syn keyword nomadiniParameter return_interface
syn keyword nomadiniParameter return_max_bandwidth
syn keyword nomadiniParameter set_ip_address
syn keyword nomadiniParameter socks_proxy_access
syn keyword nomadiniParameter source_ip_range
syn keyword nomadiniParameter source_ip_range_not
syn keyword nomadiniParameter source_port_range
syn keyword nomadiniParameter source_port_range_not
syn keyword nomadiniParameter sub_qos_class
syn keyword nomadiniParameter switch_to_alternative_peer_instance_timeout
syn keyword nomadiniParameter there_ip_range
syn keyword nomadiniParameter there_ip_range_not
syn keyword nomadiniParameter there_port_range
syn keyword nomadiniParameter there_port_range_not
syn keyword nomadiniParameter tos_range
syn keyword nomadiniParameter tos_range_not
syn keyword nomadiniParameter traffic_group
syn keyword nomadiniParameter traffic_group_bundle
syn keyword nomadiniParameter tunnel_non_tcp
syn keyword nomadiniParameter tunnel_non_tcp_recuded_headers
syn keyword nomadiniParameter tunnel_non_tcp_reduced_headers
syn keyword nomadiniParameter url_extension
syn keyword nomadiniParameter virtual_device_mode

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_nomadini_syntax_inits")
  if version < 508
    let did_nomadini_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink nomadiniHeader   Special
  HiLink nomadiniComment  Comment
  HiLink nomadiniLabel    Identifier
  HiLink nomadiniKeyword  Type
  HiLink nomadiniParameter Type
  HiLink nomadiniRange    Special
  HiLink nomadiniAddress  Special
  HiLink nomadiniHostPort Special

  delcommand HiLink
endif

let b:current_syntax = "nomadini"
