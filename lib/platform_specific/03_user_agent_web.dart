// Solo su web: attenzione! serve il pacchetto "web"
import 'package:web/web.dart' as web;

String getUserAgent() => web.window.navigator.userAgent;
