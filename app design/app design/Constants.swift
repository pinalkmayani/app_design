//
//  Constants.swift
//  app design
//
//  Created by Pinal on 09/09/2022.
//

import Foundation
import UIKit

let appdelegate = UIApplication.shared.delegate as! AppDelegate

//APP-COLORS
let appColorOrange = UIColor.init(red: 255/255, green: 149/255, blue: 0/255, alpha: 1.0)
let appColorBlue = UIColor.init(red: 46/255, green: 122/255, blue: 152/255, alpha: 1.0)
let appColorLightGray = UIColor.init(red: 209/255, green: 209/255, blue: 214/255, alpha: 1.0)

//APP-URL
let BASE_URL = "http://texting.iconnectgroup.com/api/"

let BASE_URL2 = "https://reviews.iconnectgroup.com/index.php/itextapi/"

let SIGNAL_R = "https://texting.iconnectgroup.com/signalR"

let USER_LOGIN = "login/login"

let GET_CUSTOMERS = "ChatParticipant/GetCustomers"

let GET_EMPL = "ChatParticipant/GetParticipants?code=EMPL"  //IM

let GET_CUST = "ChatParticipant/GetParticipants?code=CUST" //LEADS

let SEARCH_EMPL = "ChatParticipant/Search/EMPL/"

let SEARCH_CUST = "ChatParticipant/Search/CUST/"

let MESSAGE_WITHPARTICIPANT = "Conversation/MessagesBetween?"

let POST_MESSAGE = "Conversation/PostMessage/"

let POST_FILES = "conversation/postfiles/"

let GET_FILES = "Files/Get/"

let GOOGLE_LOCATION = "https://mybusiness.googleapis.com/v4/accounts/"

let GOOGLE_REVIEW = "https://mybusiness.googleapis.com/v4/"

let GET_CLIENTS = "values/checkclient?client="

let GET_ALL_REVIEWS = "getAllReview?"

let REVIEW_TEXT_DETAIL = "reviewTextDetail?"

let REPLY_GOOGLE_REVIEWS = "https://reviews.iconnectgroup.com/itextapi/replytoGoogleReviews?"

let GET_ALL_PARTICIPANTS = "ChatParticipant/GetAllParticipants?code=EMPL"

let COPY_MESSAGES = "Conversation/CopyMessages?"



