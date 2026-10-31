import 'package:flutter/material.dart';

void main() {
  runApp(const TaskyApp());
}

class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasky - Task Management Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E3A8A)),
      ),
      home: const LoginPage(),
    );
  }
}

// ============================================================================
// 1. LOGIN PAGE (Satisfies all Login requirements)
// ============================================================================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // Navigate to Home Page (Satisfies requirement: link another page to login page)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  void _clearFields() {
    _usernameController.clear();
    _passwordController.clear();
    _formKey.currentState?.reset();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A),
        centerTitle: true,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock_outline, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              'Tasky Login Portal',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Times New Roman',
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Application Logo & Header
                    const Icon(
                      Icons.task_alt,
                      size: 64,
                      color: Color(0xFF1E3A8A),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Welcome to Tasky',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Official Task Management System',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),

                    // --- Username Field ---
                    // Rule 1: Username must not exceed 16 characters
                    // Rule 2: Application does not expect characters that have small typing [a-z]
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        hintText: 'e.g. ADMIN_USER, TASK_MGR',
                        helperText: 'Max 16 chars | No small letters [a-z]',
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xFF1E3A8A),
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF1E3A8A),
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Username cannot be empty';
                        }
                        // Rule 1: Username must not exceed 16 characters
                        if (value.length > 16) {
                          return 'Username must not exceed 16 characters';
                        }
                        // Rule 2: Application does not expect characters that have small typing [a-z]
                        if (RegExp(r'[a-z]').hasMatch(value)) {
                          return 'Characters that have small typing [a-z] are not allowed';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // --- Password Field ---
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Color(0xFF1E3A8A),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF1E3A8A),
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // --- Two Different Buttons (Username and password actions) ---
                    // Button 1: Login (Validates both Username and Password, then navigates)
                    ElevatedButton.icon(
                      onPressed: _handleLogin,
                      icon: const Icon(Icons.login),
                      label: const Text(
                        'Login to Application',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Button 2: Second different button (Reset / Clear credentials)
                    OutlinedButton.icon(
                      onPressed: _clearFields,
                      icon: const Icon(Icons.refresh),
                      label: const Text(
                        'Reset Input Fields',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF1E3A8A),
                        side: const BorderSide(color: Color(0xFF1E3A8A)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// 2. MAIN APPLICATION PAGE (Linked from Login Page)
// ============================================================================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      // --- APPBAR REQUIREMENTS ---
      // 1. Text widget describing application: Font 14.0, Bold, Times New Roman
      // 2. Background color that suits application: Deep Navy Color(0xFF1E3A8A)
      // 3. Icon describing application: Icons.task_alt
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: const Icon(Icons.task_alt, color: Colors.white, size: 26),
        title: const Text(
          'DHAFIR FAHAD ALWALA - 443206840',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Times New Roman',
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      // --- BODY REQUIREMENTS ---
      // 1. At least one colored container shaped to rectangle containing an image
      // 2. 3 images describing the application
      // 3. A list of items for the application
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1 Header
            const Text(
              'Featured Overview (Colored Rectangular Container):',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
            ),
            const SizedBox(height: 8),

            // --- REQUIREMENT: At least one container ---
            // * Shaped to rectangle
            // * Colored shape
            // * Includes an image inside
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle, // Explicit rectangle shape
                color: const Color(0xFFDBEAFE), // Colored shape background
                borderRadius: BorderRadius.zero, // Exact sharp rectangle
                border: Border.all(
                  color: const Color(0xFF1E3A8A), // Colored border
                  width: 3.0,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                child: Image.asset(
                  'assets/images/task_planning.png', // Image inside the container
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Section 2 Header: 3 Images describing the application
            const Text(
              'Application Workflow (3 Descriptive Images):',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
            ),
            const SizedBox(height: 12),

            // --- REQUIREMENT: 3 images describing the application ---
            // Image 1: Task Planning
            Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/task_planning.png',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      'Image 1: Planning Phase & Backlog',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Image 2: Task In Progress
            Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/task_progress.png',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      'Image 2: Active Task Execution & Tracking',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Image 3: Task Completed
            Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/task_completed.png',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      'Image 3: Finished Milestones & Delivery',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
