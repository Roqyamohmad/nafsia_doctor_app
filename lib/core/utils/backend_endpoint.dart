class BackendEndpoint {
  static const String baseUrl = 'https://nafsia.up.railway.app/api/v1/';
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
  static String updateAppointment(String postId) => 'appointment/$postId';
  static String deleteAppointment(String postId) => 'appointment/$postId';
  static String getAppointments = 'appointment';

  static String createCommunitySession = '/session/community-session';
}
