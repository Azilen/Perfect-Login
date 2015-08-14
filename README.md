# Perfect Login
--
This sample project gives you example of UIView animations & autolayout combination. I have tried this combination using a sample of login screen.

1. Spring Animation
If you want to spring any of your object / control, just use usingSpringWithDamping in UIVIew animateWithDuration block. You can pass damping ratios for spring velocity. I have used NSLayoutConstraint outlet to change objects position at runtime.
![alt tag](https://github.com/Azilen/Perfect-Login/blob/master/Videos/Perfect_Login_1.gif)
--

2. Glow Animation
You can use Layer to give a glow or shadow effect to any object. Here we came up with an idea where instead of showing alert message for invalid user input, we just glow the field with red color.
![alt tag](https://github.com/Azilen/Perfect-Login/blob/master/Videos/Perfect_Login_2.gif)
--

3. Scale using constraint
NSLayoutConstraint can be a best to scale object at runtime. You can also animate them while scaling using setNeedsUpdateConstraints. Here i have reused login button as a process indicator, by resizing it using constraint.
![alt tag](https://github.com/Azilen/Perfect-Login/blob/master/Videos/Perfect_Login_3.gif)
--
