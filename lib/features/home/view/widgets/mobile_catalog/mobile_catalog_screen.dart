import 'package:flutter/material.dart';
import 'package:bookit/core/helper/dio/dio_helper.dart';

typedef CatalogLoader = Future<Map<String, dynamic>> Function(String country);

Future<Map<String, dynamic>> loadMobileCatalog(String country) async {
  final response = await DioHelper.getData(
    url: 'mobile-catalog',
    query: {'country': country},
  );
  if (response.statusCode != 200 || response.data is! Map) {
    throw const FormatException('Catalog unavailable');
  }
  final data = Map<String, dynamic>.from(response.data['data'] as Map);
  if (data['is_demo'] != true ||
      data['bookable'] != false ||
      data['academies'] is! List) {
    throw const FormatException('Invalid demo catalog');
  }
  return data;
}

class MobileCatalogEntry extends StatelessWidget {
  const MobileCatalogEntry({super.key});

  @override
  Widget build(BuildContext context) {
    final ar = Localizations.localeOf(context).languageCode == 'ar';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        color: const Color(0xff101b22),
        child: ListTile(
          leading: const Icon(Icons.explore_outlined, color: Color(0xffaaf448)),
          title: Text(
              ar ? 'أكاديميات وتدريبات مصر وقطر' : 'Academies in Egypt & Qatar',
              style: const TextStyle(color: Colors.white)),
          subtitle: Text(
              ar
                  ? '30 جهة · 90 برنامجًا تجريبيًا · استكشف الآن'
                  : '30 academies · 90 demo programs · Explore',
              style: const TextStyle(color: Color(0xffd5e2e8))),
          trailing: const Icon(Icons.chevron_right, color: Colors.white),
          onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (_) => const MobileCatalogScreen())),
        ),
      ),
    );
  }
}

class MobileCatalogScreen extends StatefulWidget {
  const MobileCatalogScreen({super.key, this.loader});
  final CatalogLoader? loader;

  @override
  State<MobileCatalogScreen> createState() => _MobileCatalogScreenState();
}

class _MobileCatalogScreenState extends State<MobileCatalogScreen> {
  String _country = 'eg';
  late Future<Map<String, dynamic>> _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _future = (widget.loader ?? loadMobileCatalog)(_country);
  }

  String text(String ar, String en) =>
      Localizations.localeOf(context).languageCode == 'ar' ? ar : en;

  @override
  Widget build(BuildContext context) {
    final ar = Localizations.localeOf(context).languageCode == 'ar';
    return Scaffold(
      appBar: AppBar(
          title: Text(text('أكاديميات وتدريبات', 'Academies & programs'))),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(
                text(
                    'بيانات تجريبية: الأسعار والمدربون والمواقع والمواعيد تحتاج تحققًا. لا حجز أو دفع.',
                    'Demo data: prices, coaches, locations and schedules are unverified. No bookings or payments.'),
                style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: const Key('catalog-country'),
              initialValue: _country,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: text('الدولة', 'Country')),
              items: [
                DropdownMenuItem(
                    value: 'eg', child: Text(text('مصر — EGP', 'Egypt — EGP'))),
                DropdownMenuItem(
                    value: 'qa', child: Text(text('قطر — QAR', 'Qatar — QAR'))),
              ],
              onChanged: (value) {
                if (value == null || value == _country) return;
                setState(() {
                  _country = value;
                  _reload();
                });
              },
            ),
          ]),
        ),
        Expanded(
            child: FutureBuilder<Map<String, dynamic>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(text('تعذّر تحميل المحتوى', 'Unable to load catalog')),
                TextButton(
                    onPressed: () => setState(_reload),
                    child: Text(text('إعادة المحاولة', 'Retry'))),
              ]));
            }
            final academies = snapshot.data!['academies'] as List;
            if (academies.isEmpty) {
              return Center(
                  child: Text(text('لا يوجد محتوى حاليًا', 'No content yet')));
            }
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              itemCount: academies.length,
              itemBuilder: (context, index) {
                final academy =
                    Map<String, dynamic>.from(academies[index] as Map);
                final trainings = academy['trainings'] as List;
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ExpansionTile(
                    key: ValueKey(academy['key']),
                    leading: const Icon(Icons.sports),
                    title: Text('${academy[ar ? 'name_ar' : 'name']}'),
                    subtitle: Text(
                        '${academy[ar ? 'sport_ar' : 'sport_en']} · ${text('تجريبي', 'Demo')}'),
                    childrenPadding: const EdgeInsets.all(16),
                    expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (academy['illustration_url'] is String) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                              academy['illustration_url'] as String,
                              height: 150,
                              fit: BoxFit.cover,
                              cacheWidth: 700,
                              errorBuilder: (_, __, ___) =>
                                  const SizedBox.shrink()),
                        ),
                        Text(
                            text('صورة توضيحية لحجّز، وليست صورة الجهة',
                                'Illustrative Hagzz artwork, not an academy photo'),
                            style: const TextStyle(fontSize: 11)),
                        const SizedBox(height: 12),
                      ],
                      Text(
                          '${text('موقع تجريبي', 'Demo location')}: ${academy['location']}'),
                      Text(
                          '${text('مدرب افتراضي', 'Fictional coach')}: ${academy['coach']}'),
                      Text(
                          text('الشعار الرسمي بانتظار التحقق',
                              'Official logo awaiting verification'),
                          style: const TextStyle(fontSize: 12)),
                      for (final item in trainings) ...[
                        const Divider(height: 24),
                        Text('${item[ar ? 'name_ar' : 'name_en']}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                            '${item['price']} ${item['currency']} · ${item['sessions']} ${text('حصص — سعر مقترح للباقة', 'sessions — proposed package price')}'),
                        Text(
                            '${item[ar ? 'weekdays_ar' : 'weekdays_en']} · ${item['start_time']}–${item['end_time']}'),
                        Text('${item['start_date']} → ${item['end_date']}'),
                        Text('${item['timezone']}',
                            style: const TextStyle(fontSize: 12)),
                      ],
                      const SizedBox(height: 16),
                      Text(
                          text('للعرض التجريبي فقط — الحجز والدفع غير متاحين',
                              'Demo only — booking and payment unavailable'),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                );
              },
            );
          },
        )),
      ]),
    );
  }
}
