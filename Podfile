use_frameworks!

def shared_pods
  pod 'DVB', :git => 'git@github.com:kiliankoe/DVB.git', :branch => 'master'
end

target 'WatchDVB' do
  platform :ios, '10.0'
  shared_pods
end

#target 'WatchDVB WatchKit App' do
#
#end

target 'WatchDVB WatchKit Extension' do
    platform :watchos, '2.0'
    shared_pods
end

