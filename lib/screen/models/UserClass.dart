class Userclass{

   late String userName , userId , fcmToken , userNumber  , userEmail  ,userPassword ;

   Userclass(this.userName, this.userId, this.fcmToken, this.userNumber,
      this.userEmail, this.userPassword);

   @override
  String toString() {
    return 'Userclass{userName: $userName, userId: $userId, fcmToken: $fcmToken, userNumber: $userNumber, userEmail: $userEmail, userPassword: $userPassword}';
  }
}