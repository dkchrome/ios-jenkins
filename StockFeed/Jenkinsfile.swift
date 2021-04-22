
node('iOS Node') {

    stage('Checkout/Build/Test') {

        // Checkout files.
        checkout([
            $class: 'GitSCM',
            branches: [[name: 'main']],
            doGenerateSubmoduleConfigurations: false,
            extensions: [], submoduleCfg: [],
            userRemoteConfigs: [[
                name: 'github',
                url: 'https://github.com/dkchrome/ios-jenkins.git'
            ]]
        ])

        // Build and Test
        sh 'xcodebuild -scheme "StockFeed" -configuration "Debug" build test -destination "platform=iOS Simulator,name=iPhone 11,OS=14.4" '

        
    }

    
}