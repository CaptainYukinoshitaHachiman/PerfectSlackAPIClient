//
//  SlackMessage.swift
//  PerfectSlackAPIClient
//
//  Created by Sven Tiigi on 11.01.18.
//

import ObjectMapper

/// Messages act as delivery vehicle for all interactive message experiences.
/// Use them not only when initiating messages, but also when updating or creating evolving workflows.
public struct SlackMessage {
    
    /// The basic text of the message.
    /// Only required if the message contains zero attachments.
    var text: String?
    
    /// Provide a JSON array of attachment objects.
    /// Adds additional components to the message.
    // Messages should contain no more than 20 attachments.
    var attachments: [SlackAttachment]?
    
    /// When replying to a parent message, this value is the ts value
    /// of the parent message to the thread. See message threading for more context.
    var threadTimestamp: String?
    
    /// Expects one of two values:
    /// in_channel — display the message to all users in the channel where a message button was clicked.
    /// Messages sent in response to invoked button actions are set to in_channel by default.
    /// ephemeral — display the message only to the user who clicked a message button.
    /// Messages sent in response to Slash commands are set to ephemeral by default.
    /// This field cannot be specified for a brand new message and must be used only in response
    /// to the execution of message button action or a slash command response.
    /// Once a response_type is set, it cannot be changed when updating the message.
    var responseType: ResponseType?
    
    /// Used only when creating messages in response to a button action invocation.
    /// When set to true, the inciting message will be replaced by this message you're providing.
    /// When false, the message you're providing is considered a brand new message.
    var replaceOriginal: Bool?
    
    /// Used only when creating messages in response to a button action invocation.
    /// When set to true, the inciting message will be deleted and if a message is provided,
    /// it will be posted as a brand new message.
    var deleteOriginal: Bool?
    
    var markdownEnabled: Bool?
    
}

// MARK: Enums

public extension SlackMessage {
    
    /// The SlackMessage Response Type
    enum ResponseType: String {
        /// Display the message to all users in the channel where a message button was clicked.
        /// Messages sent in response to invoked button actions are set
        case inChannel = "in_channel"
        /// Display the message only to the user who clicked a message button.
        /// Messages sent in response to Slash
        case ephemeral
    }
    
}

// MARK: Mappable

extension SlackMessage: Mappable {
    
    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
        self.text <- map["text"]
        self.attachments <- map["attachments"]
        self.threadTimestamp <- map["thread_ts"]
        self.responseType <- map["response_type"]
        self.replaceOriginal <- map["replace_original"]
        self.deleteOriginal <- map["delete_original"]
        self.markdownEnabled <- map["mrkdwn"]
    }
    
}