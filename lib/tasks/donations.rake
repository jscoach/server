namespace :app do
  desc "Temporary task to find donation links from readmes for existing packages"
  task :donations => :environment do
    begin
      packages = Package.published
        .where("readme ~* '.*(opencollective|patreon|paypal|liberapay|salt.bountysource).*'")

      packages.find_each do |package|
        donation_url = Donation.find_link package.readme

        if donation_url.present?
          package.donation_url = donation_url
          package.save!
          JsCoach.log "Found donation url '#{ donation_url }' for package #{ package.name }"
        else
          JsCoach.warn "Unable to parse donation url for package #{ package.name }"
        end
      end
    rescue => e
      JsCoach.error e.to_s
      ExceptionNotifier.notify_exception(e) # Send backtrace
    end
  end
end
