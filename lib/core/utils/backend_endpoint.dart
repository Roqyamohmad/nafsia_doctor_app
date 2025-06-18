class BackendEndpoint {
  static const String baseUrl = 'https://nafsia-v2.up.railway.app/api/v1/';
  static const String forgetPassword = 'auth/forgot-password';
  static const String verifyOtp = 'auth/verify-otp';
  static const String resetPassword = 'auth/reset-password';
  static const String signUp = 'auth/register';
  static const String logIn = 'auth/login';
  static const String logout = 'auth/logout';

  static const String addPost = 'post';
  static const String getAllPosts = 'post';
  static const String reactPost = 'react';
  static const String getPostReactions = 'react';
  static const String savePost = 'saved-posts';
  static String deletePost(String postId) => 'post/$postId';
  static String updatePost(String postId) => 'post/$postId';

  static const String getUserData = 'user';
  static const String updateUserProfile = 'user';
  static const String changeUserPassword = 'user';

  static const String addAppointment = 'appointment';
  static String updateAppointment(String appointmentId) =>
      'appointment/$appointmentId';
  static String deleteAppointment(String appointmentId) =>
      'appointment/$appointmentId';
  static String getAppointments = 'appointment';

  static String createCommunitySession = 'session/community-session';
  static String getSessionsById(String postId) => 'session/$postId';
  static String getSeessions = 'session';
  static String updateSessionComplete(String sessionId) =>
      'session/$sessionId/complete';
  static String confermCancleSession(String sessionId) =>
      '/session/private-session/$sessionId/confirm';

  static String addmessage = 'message';
  static String getAllMessages(String messageId) => 'message/$messageId';
  static String deleteMessage(String messageId) => 'message/$messageId';
  static String updateMessage(String messageId) => 'message/$messageId';
}
