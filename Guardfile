# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', :version => 2, :all_after_pass => false, :cli => '--tag focus' do


  watch(%r{^spec/controllers/.+_spec\.rb$})
  watch(%r{^spec/models/.+integration_spec\.rb$})
  watch(%r{^spec/helpers/.+_spec\.rb$})
  watch(%r{^spec/mailers/.+_spec\.rb$})
  watch(%r{^spec/support/.+_spec\.rb$})
  watch(%r{^spec/routing/.+_spec\.rb$})
  watch(%r{^spec/requests/.+_spec\.rb$})


  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  do |m|
    ["spec/routing/#{m[1]}_routing_spec.rb",
     "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb",
     "spec/acceptance/#{m[1]}_spec.rb",
     (m[1][/_pages/] ? "spec/requests/#{m[1]}_spec.rb" : 
                       "spec/requests/#{m[1].singularize}_pages_spec.rb")]
  end
  watch(%r{^app/views/(.+)/}) do |m|
    (m[1][/_pages/] ? "spec/requests/#{m[1]}_spec.rb" : 
                       "spec/requests/#{m[1].singularize}_pages_spec.rb")
  end
end

