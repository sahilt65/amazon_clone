// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "/address-screen";
  final String amount;
  const AddressScreen({
    Key? key,
    required this.amount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressFormKey = GlobalKey<FormState>();

  final String applepayjson = ''' 
  {
    "provider": "apple_pay",
    "data": {
      "merchantIdentifier": "merchant.com.sams.fish",
      "displayName": "Sam's Fish",
      "merchantCapabilities": ["3DS", "debit", "credit"],
      "supportedNetworks": ["amex", "visa", "discover", "masterCard"],
      "countryCode": "US",
      "currencyCode": "USD",
      "requiredBillingContactFields": ["post"],
      "requiredShippingContactFields": ["post", "phone", "email", "name"],
      "shippingMethods": [
        {
          "amount": "0.00",
          "detail": "Available within an hour",
          "identifier": "in_store_pickup",
          "label": "In-Store Pickup"
        },
        {
          "amount": "4.99",
          "detail": "5-8 Business Days",
          "identifier": "flat_rate_shipping_id_2",
          "label": "UPS Ground"
        },
        {
          "amount": "29.99",
          "detail": "1-3 Business Days",
          "identifier": "flat_rate_shipping_id_1",
          "label": "FedEx Priority Mail"
        }
      ]
    }
  }
  ''';

  final String googlePayJson = ''' 
  {
    "provider": "google_pay",
    "data": {
      "environment": "TEST",
      "apiVersion": 2,
      "apiVersionMinor": 0,
      "allowedPaymentMethods": [
        {
          "type": "CARD",
          "tokenizationSpecification": {
            "type": "PAYMENT_GATEWAY",
            "parameters": {
              "gateway": "example",
              "gatewayMerchantId": "gatewayMerchantId"
            }
          },
          "parameters": {
            "allowedCardNetworks": ["VISA", "MASTERCARD"],
            "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
            "billingAddressRequired": true,
            "billingAddressParameters": {
              "format": "FULL",
              "phoneNumberRequired": true
            }
          }
        }
      ],
      "merchantInfo": {
        "merchantId": "01234567890123456789",
        "merchantName": "Example Merchant Name"
      },
      "transactionInfo": {
        "countryCode": "US",
        "currencyCode": "USD"
      }
    }
  }
  ''';

  final TextEditingController _flatBuildingController = TextEditingController();
  final TextEditingController _areaStreetController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _townCityController = TextEditingController();
  AddressServices addressServices = AddressServices();
  String addressToBeUsed = '';

  @override
  void dispose() {
    super.dispose();
    _flatBuildingController.dispose();
    _areaStreetController.dispose();
    _pincodeController.dispose();
    _townCityController.dispose();
  }

  void onApplePayResult(res) {
    if (Provider.of<2>(context, listen: false).user.address.isEmpty) {
      addressServices.saveUserAddress(context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse(widget.amount));
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false).user.address.isEmpty) {
      addressServices.saveUserAddress(context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse(widget.amount));
  }

  void payPressed(String addressFormProvider) {
    addressToBeUsed = "";

    bool isForm = _flatBuildingController.text.isNotEmpty ||
        _areaStreetController.text.isNotEmpty ||
        _pincodeController.text.isNotEmpty ||
        _townCityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            "${_flatBuildingController.text}, ${_areaStreetController.text}, ${_townCityController.text} - ${_pincodeController.text}";
      } else {
        throw Exception("Please Enter all the values");
      }
    } else if (addressFormProvider.isNotEmpty) {
      addressToBeUsed = addressFormProvider;
    } else {
      showSnackBar(context, "Error");
    }

    print(addressToBeUsed);
  }

  List<PaymentItem> paymentItems = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentItems.add(PaymentItem(
      amount: widget.amount,
      label: "Total Amount",
      status: PaymentItemStatus.final_price,
    ));
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _addressFormKey,
            child: Column(
              children: [
                if (address.isNotEmpty)
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            address,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "OR",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                CustomTextField(
                  controller: _flatBuildingController,
                  hintText: "Flat, House No. Building",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: _areaStreetController,
                  hintText: "Area, Street",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: _pincodeController,
                  hintText: "Pincode",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: _townCityController,
                  hintText: "Town, City",
                ),
                const SizedBox(
                  height: 15,
                ),
                ApplePayButton(
                  onPressed: () => payPressed(address),
                  width: double.infinity,
                  style: ApplePayButtonStyle.whiteOutline,
                  type: ApplePayButtonType.buy,
                  paymentConfiguration: PaymentConfiguration.fromJsonString(applepayjson),
                  paymentItems: paymentItems,
                  onPaymentResult: onApplePayResult,
                  height: 45,
                  margin: const EdgeInsets.only(top: 15),
                ),
                const SizedBox(
                  height: 15,
                ),
                GooglePayButton(
                  onPressed: () => payPressed(address),
                  paymentConfiguration: PaymentConfiguration.fromJsonString(googlePayJson),
                  onPaymentResult: onGooglePayResult,
                  paymentItems: paymentItems,
                  // height: 45,
                  width: double.infinity,
                  type: GooglePayButtonType.buy,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
