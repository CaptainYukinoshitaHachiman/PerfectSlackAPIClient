<p align="center">
	<img src="https://raw.githubusercontent.com/SvenTiigi/PerfectSlackAPIClient/gh-pages/readMeAssets/logo.png" alt="logo">
</p>
<br/>
<p align="center">
	<a href="https://developer.apple.com/swift/" target="_blank">
		<img src="https://img.shields.io/badge/Swift-4.0-orange.svg" alt="Swift 3.2">
	</a>
	<img src="https://img.shields.io/badge/platform-macOS%20%7C%20Linux-yellow.svg" alt="Platform">
	<a href="https://sventiigi.github.io/PerfectSlackAPIClient" target="_blank">
		<img src="https://github.com/SvenTiigi/PerfectSlackAPIClient/blob/gh-pages/badge.svg" alt="Docs">
	</a>
	<a href="https://twitter.com/SvenTiigi" target="_blank">
		<img src="https://img.shields.io/badge/contact-@SvenTiigi-blue.svg" alt="@SvenTiigi">
	</a>
</p>

PerfectSlackAPIClient is an API Client to access the [Slack API](https://api.slack.com) from your [Perfect Server Side Swift](https://github.com/PerfectlySoft/Perfect) application. It is build on top of [PerfectAPIClient](https://github.com/SvenTiigi/PerfectAPIClient), a network abstraction layer to perform network requests from your Perfect Server Side Swift application

# Installation
To integrate using Apple's [Swift Package Manager](https://swift.org/package-manager/), add the following as a dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/SvenTiigi/PerfectSlackAPIClient.git", from: "1.0.0")
```
Here's an example `PackageDescription`:

```swift
// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "MyPackage",
    products: [
        .library(
            name: "MyPackage",
            targets: ["MyPackage"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/SvenTiigi/PerfectSlackAPIClient.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "MyPackage",
            dependencies: ["PerfectSlackAPIClient"]
        ),
        .testTarget(
            name: "MyPackageTests",
            dependencies: ["MyPackage", "PerfectSlackAPIClient"]
        )
    ]
)
```

# Setup
In order to send a message to your Slack-Channel, you have to generate a `Webhook URL` for your Slack-Workspace.
Check out the Slack API [Hello world example](https://api.slack.com/tutorials/slack-apps-hello-world). After you successfully generated a Slack Webhook URL you can configure the `SlackAPIClient`.

```swift
// Configure the Webhook URL
SlackAPIClient.Configuration.webhookURL = "YOUR_WEBHOOK_URL"
```

It is recommend to set the Webhook URL in your initialization code just before you start your `PerfectHTTPServer`.

# Usage
The following example demonstrates how to send a `SlackMessage`.

```swift
import PerfectAPIClient
import PerfectSlackAPIClient

// Initialize SlackMessage
var message = SlackMessage()
message.text = "Hello Developer".toMarkdown(format: .code)

// Initialize SlackAttachment
var attachment = SlackAttachment()
attachment.title = "Mindblown 🤯"
attachment.imageURL = "https://media.giphy.com/media/Um3ljJl8jrnHy/giphy.gif"

// Add the attachment to the message
message.attachments = [attachment]

// Send SlackMessage
SlackAPIClient.send(message).request { (result: APIClientResult<APIClientResponse>) in
    result.analysis(success: { (response: APIClientResponse) in
        // Check out your Slack-Channel 😎
        print(response.payload) // "ok"
    }, failure: { (error: APIClientError) in
        // SlackMessage could not be sent 😱
        // Perform error.analysis(....) to get more information
    })
}
```

Fore more details on `APIClientResult`, `APIClientResponse` and error handling check out [PerfectAPIClient](https://github.com/SvenTiigi/PerfectAPIClient).

# SlackMessage
The `SlackMessage` offers two important features which will be explained in the upcoming sections. 

### Message Builder Preview
You can generate a [Slack Message Builder](https://api.slack.com/docs/messages/builder) URL from your `SlackMessage` to get a brief look of how your message will be presented in your Slack-Channel.

```swift
// Initialize SlackMessage
let message = SlackMessage(text: "Posted via PerfectSlackAPIClient")

// Print Slack Message Builder Preview URL
print(message.messageBuilderPreviewURL)
```

This example will generate the following url

[https://api.slack.com/docs/messages/builder?msg=%7B%22text%22:%22Posted%20via%20PerfectSlackAPIClient%22%7D](https://api.slack.com/docs/messages/builder?msg=%7B%22text%22:%22Posted%20via%20PerfectSlackAPIClient%22%7D)

<p align="center">
	<img src="https://raw.githubusercontent.com/SvenTiigi/PerfectSlackAPIClient/gh-pages/readMeAssets/message_builder_example.png" alt="Message Builder Example Preview">
</p>

### Send
As an alternative way of sendind a `SlackMessage`, the object itself has a convienence function `send` to just send and forget or supply `success` and `failure` closure.

```swift
// Initialize SlackMessage
let message = SlackMessage(text: "Foo Bar")

// Send and forget
message.send()

// Success and failure closure
message.send(success: { (response: APIClientResponse) in
    // Success
}, failure: { (error: APIClientError) in
    // Failure
})
```

# Slack Messages API
All properties are fully documented with the Slack Messages API definition. The complete documentation can be found at [https://api.slack.com/docs/messages](https://api.slack.com/docs/messages).

# Dependencies
PerfectSlackAPIClient is using the following dependencies:

* [PerfectAPIClient](https://github.com/SvenTiigi/PerfectAPIClient)

# Contributing
Contributions are very welcome 🙌 🤓

# To-Do
- [ ] Integrate the full Slack API
- [ ] Improve Unit-Tests
- [ ] Add Travis CI
- [ ] Add Github-Pages Jazzy documentation

# License

```
MIT License

Copyright (c) 2018 Sven Tiigi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
