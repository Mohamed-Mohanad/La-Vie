import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie_app/cubit/product/product_cubit.dart';
import 'package:la_vie_app/view/plant_details/plant_details_screen.dart';
import 'package:la_vie_app/view/scan/components/qr_scanner_overlay.dart';

import 'package:mobile_scanner/mobile_scanner.dart';

import '../../core/utils/navigation.dart';

class ScanScreen extends StatelessWidget {
  MobileScannerController cameraController = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is GetPlantDetailsSuccessfulState) {
          NavigationUtils.navigateAndClearStack(
            context: context,
            destinationScreen: PlantDetailsScreen(
              plant: ProductCubit.get(context).scannedPlant!,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Scanner'),
          centerTitle: true,
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state as TorchState) {
                    case TorchState.off:
                      return const Icon(Icons.flash_off, color: Colors.grey);
                    case TorchState.on:
                      return const Icon(Icons.flash_on, color: Colors.yellow);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.toggleTorch(),
            ),
          ],
        ),
        body: Stack(
          children: [
            MobileScanner(
              allowDuplicates: false,
              controller: cameraController,
              onDetect: (barcode, args) {
                if (barcode.rawValue == null) {
                  debugPrint('Failed to scan Barcode');
                } else {
                  final String code = barcode.rawValue!;
                  debugPrint('Barcode found! $code');
                  ProductCubit.get(context)
                      .getPlantDetails("09512240-30c7-422b-91a2-5110d33c0f1f");
                }
              },
            ),
            QRScannerOverlay(
              overlayColour: Colors.black.withOpacity(
                0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
