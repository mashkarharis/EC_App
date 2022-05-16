import 'dart:async';
import 'package:app/services/apiService.dart';
import 'package:app/services/fireService.dart';
import 'package:app/services/storeService.dart';
import 'package:flutter/material.dart';

class MyAccount extends StatefulWidget {
  final dynamic data;
  const MyAccount(this.data, Key? key) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            BuildForm(context)
          ],
        ),
      ),
    );
  }

  Widget BuildForm(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.99,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text("My Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                  fontSize: 25,
                )),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: widget.data['nic'],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some nic';
                }
                return null;
              },
              enabled: false,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {});
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.info),
                hintText: 'Enter NIC',
                labelText: 'NIC',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: widget.data['name'],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some name';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {});
              },
              enabled: false,
              decoration: const InputDecoration(
                icon: Icon(Icons.info),
                hintText: 'Enter Name',
                labelText: 'Name',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: widget.data['phone'],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some Phone';
                }
                return null;
              },
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                setState(() {});
              },
              enabled: false,
              decoration: const InputDecoration(
                icon: Icon(Icons.phone),
                hintText: 'Enter a phone number',
                labelText: 'Phone',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: widget.data['address'],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some address';
                }
                return null;
              },
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                setState(() {});
              },
              enabled: false,
              minLines: 1,
              maxLines: 100,
              decoration: const InputDecoration(
                icon: Icon(Icons.info),
                hintText: 'Enter Address',
                labelText: 'Address',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: widget.data['email'],
              validator: (value) {
                return null;
              },
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {});
              },
              enabled: false,
              decoration: const InputDecoration(
                icon: Icon(Icons.info),
                hintText: 'Enter Email',
                labelText: 'Email',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
