# Listify - Not your everyday todo app!
<img src="https://github.com/dinurymomshad/listify/blob/main/assets/App%20Logo.png" height=70 align="left"> 
<p>A task management app with refreshing UI. Organise your tasks and share projects on the go. Track status of project, discuss ideas about tasks in dedicated discussion thread. It can be used as a regular To Do List App or can be used to plan and execute big events. 
</p>
<table>
  <tr>
    <td>Splash Screen</td>
     <td>Login Screen</td>
     <td>Home Screen</td>
     <td>Details Screen</td>
  </tr>
  <tr>
    <td><img src="https://github.com/dinurymomshad/listify/blob/main/assets/screenshots/Splash%20Screen.png" width=270 ></td>
    <td><img src="https://github.com/dinurymomshad/listify/blob/main/assets/screenshots/Login%20Screen.png" width=270 ></td>
    <td><img src="https://github.com/dinurymomshad/listify/blob/main/assets/screenshots/Home%20Screen.png" width=270 ></td>
    <td><img src="https://github.com/dinurymomshad/listify/blob/main/assets/screenshots/Details%20Screen.png" width=270 ></td>
  </tr>
 </table>
 
## Project Environment:
```
Flutter 2.5.3 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 18116933e7 (4 weeks ago) • 2021-10-15 10:46:35 -0700
Engine • revision d3ea636dc5
Tools • Dart 2.14.4
```

## Code Flow:
Project is following MVC pattern. For managing state I am using Riverpod 1.0.0. All the UI components are inside views folder. Business logic is handled inside controller folder. Model is used to parse data.

```
└── lib/
    ├── controller/
    │   └── business logic layer
    ├── model/
    │   └── data layer
    ├── view/
    │   └── presentation layer
    ├── services/
    │   └── helper classes
    └── constant
```

## Feature List
```
├── Login & Sign up using Email and Password
├── Add Task with title, description, date and time, priority
├── Add, Update, Delete Sub Task
├── Update Task
└── Delete Task
```
```P.S - To see on going work, feature list please check issues section and projects section```


To learn more about riverpod:<br>
https://codewithandrea.com/videos/flutter-state-management-riverpod/<br>
To learn more about MVC pattern:<br>
https://medium.flutterdevs.com/design-patterns-in-flutter-part-1-c32a3ddb00e2<br>
To Install flutter:<br>
https://flutter.dev/docs/get-started/install

