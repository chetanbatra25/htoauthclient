CLIENT = OAuth2::Client.new(
    'aGSETwbeKgbUMGq_KCPOssPF6G8S4Ty9N3Je1rCezVg',
    'xznRf_rzZSLxTenplmbMTGbrbQdBYRkcAnokKY6VGXs',
    :site   => 'http://localhost:3002',
    :logger => Logger.new('example.log', 'weekly')
  )