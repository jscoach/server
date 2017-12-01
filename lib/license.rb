module License
  SPDX_LICENSE_IDS_FILE = "node_modules/spdx-license-list/spdx-simple.json"

  # Tries to return a valid SPDX license ID
  def self.normalize(license, fallback: license)
    # Create hash to ignore casing (eg: { "APACHE-2.0": "Apache-2.0", ... })
    licenses = Hash[spdx_license_ids.map { |v| [v.upcase, v] }]

    # Return the version with proper casing
    return licenses[license.upcase] if licenses.keys.include?(license.upcase)

    # Other common mistakes
    case license.upcase
    when /^APACHE[\-\s]?V?2(\.0)?$/
      "Apache-2.0"
    when /^GPL[\-\s]?V?2(\.0)?$/
      "GPL-2.0"
    when /^GPL[\-\s]?V?3(\.0)?$/
      "GPL-3.0"
    when /^CC0[\-\s]?(1\.0)?$/
      "CC0-1.0"
    else
      fallback
    end
  end

  private

  # Reads list of license IDs from: https://git.io/vFhAX
  def self.spdx_license_ids
    @_spdx_license_ids ||= JSON.parse(File.read(SPDX_LICENSE_IDS_FILE))
  end
end
