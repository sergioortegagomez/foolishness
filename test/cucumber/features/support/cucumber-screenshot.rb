begin
    After do |scenario|
        if scenario.failed?
            take_screenshot
        end
    end

    AfterStep do |scenario|
        take_screenshot
    end
    rescue Exception => e
        puts "Snapshots not available for this environment.\n"
end