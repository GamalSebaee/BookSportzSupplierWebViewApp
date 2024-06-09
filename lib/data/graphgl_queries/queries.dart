class GraphQLQueries {
  static String login(
          {required String email,
          required String password,
          String usertype = "SERVICE_PROVIDER"}) =>
      ''' 
  {
  login(
    input:{
      email: "$email",
      password:"$password",
      userType:"$usertype"
    }
  ){
    id
    email
    jwtToken
  }
}
  ''';
  static String getNotifications({
    int? limit=10,
    int? offset=0,
  }) => '''
  query getNotifications{
      getNotifications(limit: $limit, offset: $offset) {
        count
        unseenCounter
        notifications {
          id
          userId
          message
          reservationId
          itemId
          itemType
          reviewId
          requestId
          type
          createdAt
          Seen
          redirect
          reservation {
            type
            __typename
          }
          __typename
        }
        __typename
      }
    }
  ''';
  static String getNotificationsCount({
    int? limit=10,
    int? offset=0,
  }) => '''
  query getNotifications{
      getNotifications(limit: $limit, offset: $offset) {
        count
        unseenCounter
    }
    }
  ''';

  static String getSelf() => '''{
  getSelf{
    id
    name
    createdAt
    updatedAt
    type
    lastLogin
    status
    email
    isEmailVerified
    isMobileNumberVerified
    language
    nationality
    loginType
    serviceProviderDetails{
        company{
            logo
        }
    }
    userDetails{
      dateOfBirth
      gender
      emergencyNumber
      photo
      firstName
      lastName
    }
  }
}''';

  static String addDeviceTokenQuery() => ''' 
  mutation addDeviceToken(\$deviceId : String!,\$fcmToken : String!){
    addDeviceToken(
        deviceId: \$deviceId,
        token: \$fcmToken
    )
} ''';

  static String deleteDeviceTokenQuery() => ''' 
  mutation deleteDeviceToken(\$deviceId : String!){
    deleteDeviceToken(
        deviceId: \$deviceId
    )
} ''';
}
