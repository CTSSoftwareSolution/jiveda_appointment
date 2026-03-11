import 'package:flutter/material.dart';
import 'package:jiveda_appointment/Presentation/providers/appointment_count_provider.dart';
import 'package:jiveda_appointment/Presentation/screens/appointment/shimmer_widget.dart';
import 'package:jiveda_appointment/utilities/color_data.dart';
import 'package:jiveda_appointment/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import '../../providers/appointment_list_provider.dart';
import 'appointment_list_widget.dart';
import 'appointment_status_widget.dart';


class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppointmentListProvider>().fetchAppointments();
      context.read<AppointmentCountProvider>().fetchCounts();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final aptProv = context.watch<AppointmentListProvider>();

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            toolbarHeight: 60,
            floating: false,
            pinned: true,
            backgroundColor: primaryColor,
            scrolledUnderElevation: 0,
            elevation: 0,
            flexibleSpace:
            FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor.withValues(alpha: 0.80),
                      appColor,],
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(20, 56, 20, 16),
                child: CustomText(text: "Appointment",textColor: whiteColor,fontSize: 20.0,fontWeight: FontWeight.bold,),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor.withValues(alpha: 0.80),
                      appColor,],
                  ),
                ),
                //color: appColor,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicatorColor: greenColor,
                  indicatorWeight: 3,
                  labelColor: whiteColor,
                  unselectedLabelColor: lightWhiteColor,
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 13),
                  tabs: const [
                    Tab(text: 'All'),
                    Tab(text: 'Scheduled'),
                    Tab(text: 'Completed'),
                    Tab(text: 'Cancelled'),
                  ],
                ),
              ),
            ),
          ),
        ],
        body: Column(
          children: [
            // Search bar
            Container(
              color: whiteColor,
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: TextField(
                controller: _searchCtrl,
                onChanged: aptProv.setSearch,
                decoration: InputDecoration(
                  hintText: 'Search by name, appointment no...',
                  hintStyle: TextStyle(fontSize: 14.0,fontWeight: FontWeight.w400,color:textHintColor),
                  prefixIcon: const Icon(Icons.search, color: textSecondaryColor),
                  suffixIcon: _searchCtrl.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchCtrl.clear();
                      aptProv.setSearch('');
                    },
                  )
                      : null,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                    const BorderSide(color: lightGreen, width: 2),
                  ),
                  filled: true,
                  fillColor: surfaceColor,
                ),
              ),
            ),
            // Stats row
            if (!aptProv.isLoading) buildStatsRow(context),
            // Appointment List
            Expanded(
              child: aptProv.isLoading
                  ? buildShimmer()
                  : TabBarView(
                controller: _tabController,
                children: [
                  buildList(aptProv.appointments, null,context),
                  buildList(aptProv.appointments, 'scheduled',context),
                  buildList(aptProv.appointments, 'completed',context),
                  buildList(aptProv.appointments, 'cancelled',context),
                ],
              ),
            ),
           // SizedBox(height: 60.0,)
          ],
        ),
      ),
    );
  }












}
