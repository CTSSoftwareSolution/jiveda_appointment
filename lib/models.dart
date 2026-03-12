class Appointment {
  final String id;
  final String appointmentNumber;
  final String clientName;
  final String clientEmail;
  final String clientPhone;
  final String date;
  final String time;
  final String status;
  String? clientPhotoPath;
  String? idCardPhotoPath;
  String? aadharPhotoPath;
  bool isDocumentUploaded;

  Appointment({
    required this.id,
    required this.appointmentNumber,
    required this.clientName,
    required this.clientEmail,
    required this.clientPhone,
    required this.date,
    required this.time,
    required this.status,
    this.clientPhotoPath,
    this.idCardPhotoPath,
    this.aadharPhotoPath,
    this.isDocumentUploaded = false,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id']?.toString() ?? '',
      appointmentNumber: json['appointment_number']?.toString() ?? '',
      clientName: json['client_name'] ?? '',
      clientEmail: json['client_email'] ?? '',
      clientPhone: json['client_phone'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      status: json['status'] ?? 'pending',
    );
  }

  // Mock factory for demo purposes
  static List<Appointment> getMockData() {
    return [
      Appointment(
        id: '1',
        appointmentNumber: 'APT-2024-001',
        clientName: 'Rahul Sharma',
        clientEmail: 'rahul@email.com',
        clientPhone: '+91 98765 43210',
        date: '2024-01-15',
        time: '10:00 AM',
        status: 'scheduled',
      ),
      Appointment(
        id: '2',
        appointmentNumber: 'APT-2024-002',
        clientName: 'Priya Patel',
        clientEmail: 'priya@email.com',
        clientPhone: '+91 87654 32109',
        date: '2024-01-15',
        time: '11:30 AM',
        status: 'completed',
        isDocumentUploaded: true,
      ),
      Appointment(
        id: '3',
        appointmentNumber: 'APT-2024-003',
        clientName: 'Arun Kumar',
        clientEmail: 'arun@email.com',
        clientPhone: '+91 76543 21098',
        date: '2024-01-15',
        time: '02:00 PM',
        status: 'scheduled',
      ),
      Appointment(
        id: '4',
        appointmentNumber: 'APT-2024-004',
        clientName: 'Deepa Menon',
        clientEmail: 'deepa@email.com',
        clientPhone: '+91 65432 10987',
        date: '2024-01-16',
        time: '09:00 AM',
        status: 'cancelled',
      ),
      Appointment(
        id: '5',
        appointmentNumber: 'APT-2024-005',
        clientName: 'Vikram Singh',
        clientEmail: 'vikram@email.com',
        clientPhone: '+91 54321 09876',
        date: '2024-01-16',
        time: '03:30 PM',
        status: 'scheduled',
      ),
      Appointment(
        id: '6',
        appointmentNumber: 'APT-2024-006',
        clientName: 'Sneha Reddy',
        clientEmail: 'sneha@email.com',
        clientPhone: '+91 43210 98765',
        date: '2024-01-17',
        time: '10:00 AM',
        status: 'scheduled',
      ),
    ];
  }
}

class UserProfile {
  final String name;
  final String email;
  final String role;
  final String employeeId;
  final String department;
  final String avatarUrl;

  UserProfile({
    required this.name,
    required this.email,
    required this.role,
    required this.employeeId,
    required this.department,
    required this.avatarUrl,
  });

  factory UserProfile.mock() {
    return UserProfile(
      name: 'Admin User',
      email: 'admin@company.com',
      role: 'Senior Verification Officer',
      employeeId: 'EMP-1042',
      department: 'KYC & Compliance',
      avatarUrl: '',
    );
  }
}
