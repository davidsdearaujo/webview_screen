part of 'webview_screen.dart';

mixin WebviewMixin<T extends StatefulWidget> on State<T> {
  WebviewBloc bloc;
  Completer<WebViewController> webviewController;

  @override
  void initState() {
    super.initState();
    bloc = WebviewBloc();
    webviewController = Completer<WebViewController>();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _navigate(context);
  }

  void _navigate(BuildContext context) async {
    var controller = await webviewController.future;
    await controller.loadUrl(_url);
  }
}