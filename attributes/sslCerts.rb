# cert = {
#   :id   => 'foo'
#   :cert => ['...', '...', ] # content for .crt
#   :key  => ['...', '...', ] # content for .key
# }

default["nginx"]["sslcertkey"]["mysitesslcert"] = {
	:id => "mysitesslcert",
	:cert => [
		"-----BEGIN CERTIFICATE-----",
		"MIIDKjCCApOgAwIBAgIJAP1tLjj7nrbsMA0GCSqGSIb3DQEBBQUAMIGtMQswCQYD",
		"..........",
		"yp3yAas+YT2BV/DNsdJZmOMFQh3OLKkh9D8idR6kS+HAtJK/PQAp9QaikBUwKg==",
		"-----END CERTIFICATE-----"
    ],
    :key => [
		"-----BEGIN PRIVATE KEY-----",
		"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMUTy7OecnjBFRmM",
		"..........",
		"4HRlGtHj8IcOCxNuJMmq6yrTpSyESYAd3wntddLNgie3TFBuPEujZ89kF6oBcn6O",
		"c7ya5F+abCTDSw==",
		"-----END PRIVATE KEY-----"
    ]
}
