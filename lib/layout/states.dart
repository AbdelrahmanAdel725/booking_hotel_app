abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppDatabaseCreatedState extends AppStates{}

class AppGetFromDatabaseState extends AppStates{}

class AppInsertToDatabaseState extends AppStates{}

class AppUpdateDatabaseState extends AppStates{}

class AppGetDatabaseLoadingState extends AppStates {}

class AppDeleteFromDatabaseState extends AppStates{}

class AppDatabaseUpdateSuccess extends AppStates{}