// Simple dummy data classes for search functionality

class PatientItem {
  final String id;
  final String name;
  final String phone;
  final int age;
  final String bloodGroup;

  PatientItem({
    required this.id,
    required this.name,
    required this.phone,
    required this.age,
    required this.bloodGroup,
  });
}

class DrugItem {
  final String id;
  final String brandName;
  final String genericName;
  final String companyName;
  final String form;

  DrugItem({
    required this.id,
    required this.brandName,
    required this.genericName,
    required this.companyName,
    required this.form,
  });
}

class SearchDummyData {
  // Dummy patient data
  static final List<PatientItem> patients = [
    PatientItem(
      id: '1',
      name: 'John Smith',
      phone: '+8801712345671',
      age: 35,
      bloodGroup: 'A+',
    ),
    PatientItem(
      id: '2',
      name: 'Sarah Johnson',
      phone: '+8801712345672',
      age: 28,
      bloodGroup: 'B+',
    ),
    PatientItem(
      id: '3',
      name: 'Michael Brown',
      phone: '+8801712345673',
      age: 42,
      bloodGroup: 'O+',
    ),
    PatientItem(
      id: '4',
      name: 'Emily Davis',
      phone: '+8801712345674',
      age: 31,
      bloodGroup: 'AB+',
    ),
    PatientItem(
      id: '5',
      name: 'David Wilson',
      phone: '+8801712345675',
      age: 55,
      bloodGroup: 'A-',
    ),
    PatientItem(
      id: '6',
      name: 'Jessica Martinez',
      phone: '+8801712345676',
      age: 26,
      bloodGroup: 'B-',
    ),
    PatientItem(
      id: '7',
      name: 'Robert Anderson',
      phone: '+8801712345677',
      age: 48,
      bloodGroup: 'O-',
    ),
    PatientItem(
      id: '8',
      name: 'Jennifer Taylor',
      phone: '+8801712345678',
      age: 39,
      bloodGroup: 'AB-',
    ),
  ];

  // Dummy medicine data
  static final List<DrugItem> drugs = [
    DrugItem(
      id: '1',
      brandName: 'Napa',
      genericName: 'Paracetamol',
      companyName: 'Beximco Pharmaceuticals',
      form: 'Tablet',
    ),
    DrugItem(
      id: '2',
      brandName: 'Ace',
      genericName: 'Paracetamol',
      companyName: 'Square Pharmaceuticals',
      form: 'Tablet',
    ),
    DrugItem(
      id: '3',
      brandName: 'Maxpro',
      genericName: 'Omeprazole',
      companyName: 'Renata Limited',
      form: 'Capsule',
    ),
    DrugItem(
      id: '4',
      brandName: 'Alatrol',
      genericName: 'Cetirizine',
      companyName: 'Square Pharmaceuticals',
      form: 'Tablet',
    ),
    DrugItem(
      id: '5',
      brandName: 'Monas',
      genericName: 'Montelukast',
      companyName: 'Incepta Pharmaceuticals',
      form: 'Tablet',
    ),
    DrugItem(
      id: '6',
      brandName: 'Seclo',
      genericName: 'Omeprazole',
      companyName: 'Square Pharmaceuticals',
      form: 'Capsule',
    ),
    DrugItem(
      id: '7',
      brandName: 'Flexi',
      genericName: 'Naproxen',
      companyName: 'Drug International',
      form: 'Tablet',
    ),
    DrugItem(
      id: '8',
      brandName: 'Ciprocin',
      genericName: 'Ciprofloxacin',
      companyName: 'Square Pharmaceuticals',
      form: 'Tablet',
    ),
    DrugItem(
      id: '9',
      brandName: 'Azithrocin',
      genericName: 'Azithromycin',
      companyName: 'Drug International',
      form: 'Tablet',
    ),
    DrugItem(
      id: '10',
      brandName: 'Sergel',
      genericName: 'Sertraline',
      companyName: 'Incepta Pharmaceuticals',
      form: 'Tablet',
    ),
  ];

  /// Search patients by name or phone
  static List<PatientItem> searchPatients(String query) {
    if (query.isEmpty || query.length < 2) return [];
    
    final lowerQuery = query.toLowerCase();
    return patients.where((patient) {
      return patient.name.toLowerCase().contains(lowerQuery) ||
          patient.phone.contains(query);
    }).toList();
  }

  /// Search drugs by brand name, generic name, or company
  static List<DrugItem> searchDrugs(String query) {
    if (query.isEmpty || query.length < 2) return [];
    
    final lowerQuery = query.toLowerCase();
    return drugs.where((drug) {
      return drug.brandName.toLowerCase().contains(lowerQuery) ||
          drug.genericName.toLowerCase().contains(lowerQuery) ||
          drug.companyName.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
