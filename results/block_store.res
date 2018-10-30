Test output
 .....
----------------------------------------------------------------------
Ran 5 tests in 1397.596s

OK

Wrote profile results to run_tests.py.lprof
Timer unit: 1e-06 s

Total time: 1.4167 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: __init__ at line 160

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   160                                               @profile
   161                                               def __init__(self, config):
   162         5         17.0      3.4      0.0          self._config = config
   163         5         14.0      2.8      0.0          self.subscription_id = str(config.get('azure_subscription_id'))
   164         5          3.0      0.6      0.0          self._credentials = ServicePrincipalCredentials(
   165         5          4.0      0.8      0.0              client_id=config.get('azure_client_id'),
   166         5          4.0      0.8      0.0              secret=config.get('azure_secret'),
   167         5    1416552.0 283310.4    100.0              tenant=config.get('azure_tenant')
   168                                                   )
   169                                           
   170         5         16.0      3.2      0.0          self._access_token = config.get('azure_access_token')
   171         5          6.0      1.2      0.0          self._resource_client = None
   172         5          5.0      1.0      0.0          self._storage_client = None
   173         5          4.0      0.8      0.0          self._network_management_client = None
   174         5          6.0      1.2      0.0          self._subscription_client = None
   175         5          6.0      1.2      0.0          self._compute_client = None
   176         5          5.0      1.0      0.0          self._access_key_result = None
   177         5          6.0      1.2      0.0          self._block_blob_service = None
   178         5          4.0      0.8      0.0          self._table_service = None
   179         5          5.0      1.0      0.0          self._storage_account = None
   180                                           
   181         5         41.0      8.2      0.0          log.debug("azure subscription : %s", self.subscription_id)

Total time: 0.999881 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: access_key_result at line 183

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   183                                               @property
   184                                               @tenacity.retry(stop=tenacity.stop_after_attempt(5), reraise=True)
   185                                               @profile
   186                                               def access_key_result(self):
   187         2          2.0      1.0      0.0          if not self._access_key_result:
   188         2          7.0      3.5      0.0              storage_account = self.storage_account
   189                                           
   190         2     497806.0 248903.0     49.8              if self.get_storage_account(storage_account).\
   191         2          2.0      1.0      0.0                      provisioning_state.value != 'Succeeded':
   192                                                           log.debug(
   193                                                               "Storage account %s is not in Succeeded state yet. ",
   194                                                               storage_account)
   195                                                           raise WaitStateException(
   196                                                               "Waited too long for storage account: {0} to "
   197                                                               "become ready.".format(
   198                                                                   storage_account,
   199                                                                   self.get_storage_account(storage_account).
   200                                                                   provisioning_state))
   201                                           
   202         2        463.0    231.5      0.0              self._access_key_result = self.storage_client.storage_accounts. \
   203         2     501597.0 250798.5     50.2                  list_keys(self.resource_group, storage_account)
   204         2          4.0      2.0      0.0          return self._access_key_result

Total time: 0.00028 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: resource_group at line 206

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   206                                               @property
   207                                               @profile
   208                                               def resource_group(self):
   209       158        280.0      1.8    100.0          return self._config.get('azure_resource_group')

Total time: 7e-06 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: storage_account at line 211

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   211                                               @property
   212                                               @profile
   213                                               def storage_account(self):
   214         6          7.0      1.2    100.0          return self._config.get('azure_storage_account')

Total time: 9e-06 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: region_name at line 216

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   216                                               @property
   217                                               @profile
   218                                               def region_name(self):
   219         3          9.0      3.0    100.0          return self._config.get('azure_region_name')

Total time: 3.3e-05 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: public_key_storage_table_name at line 221

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   221                                               @property
   222                                               @profile
   223                                               def public_key_storage_table_name(self):
   224        17         33.0      1.9    100.0          return self._config.get('azure_public_key_storage_table_name')

Total time: 0.013736 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: storage_client at line 226

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   226                                               @property
   227                                               @profile
   228                                               def storage_client(self):
   229         6          6.0      1.0      0.0          if not self._storage_client:
   230                                                       self._storage_client = \
   231         2          2.0      1.0      0.0                  StorageManagementClient(self._credentials,
   232         2      13724.0   6862.0     99.9                                          self.subscription_id)
   233         6          4.0      0.7      0.0          return self._storage_client

Total time: 0.012467 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: subscription_client at line 235

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   235                                               @property
   236                                               @profile
   237                                               def subscription_client(self):
   238         2          2.0      1.0      0.0          if not self._subscription_client:
   239         2      12463.0   6231.5    100.0              self._subscription_client = SubscriptionClient(self._credentials)
   240         2          2.0      1.0      0.0          return self._subscription_client

Total time: 0.045807 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: resource_client at line 242

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   242                                               @property
   243                                               @profile
   244                                               def resource_client(self):
   245         5          5.0      1.0      0.0          if not self._resource_client:
   246                                                       self._resource_client = \
   247         5          3.0      0.6      0.0                  ResourceManagementClient(self._credentials,
   248         5      45789.0   9157.8    100.0                                           self.subscription_id)
   249         5         10.0      2.0      0.0          return self._resource_client

Total time: 0.034362 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: compute_client at line 251

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   251                                               @property
   252                                               @profile
   253                                               def compute_client(self):
   254       136        319.0      2.3      0.9          if not self._compute_client:
   255                                                       self._compute_client = \
   256         5          9.0      1.8      0.0                  ComputeManagementClient(self._credentials,
   257         5      33902.0   6780.4     98.7                                          self.subscription_id)
   258       136        132.0      1.0      0.4          return self._compute_client

Total time: 0.014786 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: network_management_client at line 260

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   260                                               @property
   261                                               @profile
   262                                               def network_management_client(self):
   263        16         17.0      1.1      0.1          if not self._network_management_client:
   264         2          5.0      2.5      0.0              self._network_management_client = NetworkManagementClient(
   265         2      14756.0   7378.0     99.8                  self._credentials, self.subscription_id)
   266        16          8.0      0.5      0.1          return self._network_management_client

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: blob_service at line 268

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   268                                               @property
   269                                               @profile
   270                                               def blob_service(self):
   271                                                   self._get_or_create_storage_account()
   272                                                   if not self._block_blob_service:
   273                                                       if self._access_token:
   274                                                           token_credential = TokenCredential(self._access_token)
   275                                                           self._block_blob_service = BlockBlobService(
   276                                                               account_name=self.storage_account,
   277                                                               token_credential=token_credential)
   278                                                       else:
   279                                                           self._block_blob_service = BlockBlobService(
   280                                                               account_name=self.storage_account,
   281                                                               account_key=self.access_key_result.keys[0].value)
   282                                                   return self._block_blob_service

Total time: 2.45904 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: table_service at line 284

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   284                                               @property
   285                                               @profile
   286                                               def table_service(self):
   287         8     620455.0  77556.9     25.2          self._get_or_create_storage_account()
   288         8         15.0      1.9      0.0          if not self._table_service:
   289         2          5.0      2.5      0.0              self._table_service = TableService(
   290         2         16.0      8.0      0.0                  self.storage_account,
   291         2    1000721.0 500360.5     40.7                  self.access_key_result.keys[0].value)
   292         8         20.0      2.5      0.0          if not self._table_service. \
   293         8     776819.0  97102.4     31.6                  exists(table_name=self.public_key_storage_table_name):
   294         1          4.0      4.0      0.0              self._table_service.create_table(
   295         1      60955.0  60955.0      2.5                  self.public_key_storage_table_name)
   296         8         31.0      3.9      0.0          return self._table_service

Total time: 1.0522 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: get_resource_group at line 298

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   298                                               @profile
   299                                               def get_resource_group(self, name):
   300         5    1052198.0 210439.6    100.0          return self.resource_client.resource_groups.get(name)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: create_resource_group at line 302

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   302                                               @profile
   303                                               def create_resource_group(self, name, parameters):
   304                                                   return self.resource_client.resource_groups. \
   305                                                       create_or_update(name, parameters)

Total time: 1.11697 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: get_storage_account at line 307

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   307                                               @profile
   308                                               def get_storage_account(self, storage_account):
   309         4      67334.0  16833.5      6.0          return self.storage_client.storage_accounts. \
   310         4    1049640.0 262410.0     94.0              get_properties(self.resource_group, storage_account)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: create_storage_account at line 312

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   312                                               @profile
   313                                               def create_storage_account(self, name, params):
   314                                                   return self.storage_client.storage_accounts. \
   315                                                       create(self.resource_group, name.lower(), params).result()

Total time: 0.619268 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: _get_or_create_storage_account at line 319

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   319                                               @tenacity.retry(stop=tenacity.stop_after_attempt(2),
   320                                                               retry=tenacity.retry_if_exception_type(CloudError),
   321                                                               reraise=True)
   322                                               @profile
   323                                               def _get_or_create_storage_account(self):
   324         8         12.0      1.5      0.0          if self._storage_account:
   325         6          5.0      0.8      0.0              return self._storage_account
   326                                                   else:
   327         2          2.0      1.0      0.0              try:
   328                                                           self._storage_account = \
   329         2     619249.0 309624.5    100.0                      self.get_storage_account(self.storage_account)
   330                                                       except CloudError as cloud_error:
   331                                                           if cloud_error.error.error == "ResourceNotFound":
   332                                                               storage_account_params = {
   333                                                                   'sku': {
   334                                                                       'name': 'Standard_LRS'
   335                                                                   },
   336                                                                   'kind': 'storage',
   337                                                                   'location': self.region_name,
   338                                                               }
   339                                                               try:
   340                                                                   self._storage_account = \
   341                                                                       self.create_storage_account(self.storage_account,
   342                                                                                                   storage_account_params)
   343                                                               except CloudError as cloud_error2:  # pragma: no cover
   344                                                                   if cloud_error2.error.error == "AuthorizationFailed":
   345                                                                       mess = 'The following error was returned by ' \
   346                                                                              'Azure:\n%s\n\nThis is likely because the' \
   347                                                                              ' Role associated with the provided ' \
   348                                                                              'credentials does not allow for Storage ' \
   349                                                                              'Account creation.\nA Storage Account is ' \
   350                                                                              'necessary in order to perform the ' \
   351                                                                              'desired operation. You must either ' \
   352                                                                              'provide an existing Storage Account name' \
   353                                                                              ' as part of the configuration, or ' \
   354                                                                              'elevate the associated Role.\nFor more ' \
   355                                                                              'information on roles, see: https://docs.' \
   356                                                                              'microsoft.com/en-us/azure/role-based-' \
   357                                                                              'access-control/overview\n' % cloud_error2
   358                                                                       raise ProviderConnectionException(mess)
   359                                           
   360                                                                   elif cloud_error2.error.error == \
   361                                                                           "StorageAccountAlreadyTaken":
   362                                                                       mess = 'The following error was ' \
   363                                                                              'returned by Azure:\n%s\n\n' \
   364                                                                              'Note that Storage Account names must be ' \
   365                                                                              'unique across Azure (not just in your ' \
   366                                                                              'subscription).\nFor more information ' \
   367                                                                              'see https://docs.microsoft.com/en-us/' \
   368                                                                              'azure/azure-resource-manager/resource-' \
   369                                                                              'manager-storage-account-name-errors\n' \
   370                                                                              % cloud_error2
   371                                                                       raise InvalidLabelException(mess)
   372                                                                   else:
   373                                                                       raise cloud_error2
   374                                                           else:
   375                                                               raise cloud_error

Total time: 0.039382 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: list_locations at line 377

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   377                                               @profile
   378                                               def list_locations(self):
   379         2      39332.0  19666.0     99.9          return self.subscription_client.subscriptions. \
   380         2         50.0     25.0      0.1              list_locations(self.subscription_id)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: list_vm_firewall at line 382

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   382                                               @profile
   383                                               def list_vm_firewall(self):
   384                                                   return self.network_management_client.network_security_groups. \
   385                                                       list(self.resource_group)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: create_vm_firewall at line 387

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   387                                               @profile
   388                                               def create_vm_firewall(self, name, parameters):
   389                                                   return self.network_management_client.network_security_groups. \
   390                                                       create_or_update(self.resource_group, name,
   391                                                                        parameters).result()

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: update_vm_firewall_tags at line 393

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   393                                               @profile
   394                                               def update_vm_firewall_tags(self, fw_id, tags):
   395                                                   url_params = azure_helpers.parse_url(VM_FIREWALL_RESOURCE_ID,
   396                                                                                        fw_id)
   397                                                   name = url_params.get(VM_FIREWALL_NAME)
   398                                                   return self.network_management_client.network_security_groups. \
   399                                                       create_or_update(self.resource_group, name,
   400                                                                        {'tags': tags,
   401                                                                         'location': self.region_name}).result()

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: get_vm_firewall at line 403

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   403                                               @profile
   404                                               def get_vm_firewall(self, fw_id):
   405                                                   url_params = azure_helpers.parse_url(VM_FIREWALL_RESOURCE_ID,
   406                                                                                        fw_id)
   407                                                   fw_name = url_params.get(VM_FIREWALL_NAME)
   408                                                   return self.network_management_client.network_security_groups. \
   409                                                       get(self.resource_group, fw_name)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: delete_vm_firewall at line 411

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   411                                               @profile
   412                                               def delete_vm_firewall(self, fw_id):
   413                                                   url_params = azure_helpers.parse_url(VM_FIREWALL_RESOURCE_ID,
   414                                                                                        fw_id)
   415                                                   name = url_params.get(VM_FIREWALL_NAME)
   416                                                   self.network_management_client \
   417                                                       .network_security_groups.delete(self.resource_group, name).wait()

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: create_vm_firewall_rule at line 419

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   419                                               @profile
   420                                               def create_vm_firewall_rule(self, fw_id,
   421                                                                           rule_name, parameters):
   422                                                   url_params = azure_helpers.parse_url(VM_FIREWALL_RESOURCE_ID,
   423                                                                                        fw_id)
   424                                                   vm_firewall_name = url_params.get(VM_FIREWALL_NAME)
   425                                                   return self.network_management_client.security_rules. \
   426                                                       create_or_update(self.resource_group, vm_firewall_name,
   427                                                                        rule_name, parameters).result()

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: delete_vm_firewall_rule at line 429

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   429                                               @profile
   430                                               def delete_vm_firewall_rule(self, fw_rule_id, vm_firewall):
   431                                                   url_params = azure_helpers.parse_url(VM_FIREWALL_RULE_RESOURCE_ID,
   432                                                                                        fw_rule_id)
   433                                                   name = url_params.get(VM_FIREWALL_RULE_NAME)
   434                                                   return self.network_management_client.security_rules. \
   435                                                       delete(self.resource_group, vm_firewall, name).result()

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: list_containers at line 437

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   437                                               @profile
   438                                               def list_containers(self, prefix=None, limit=None, marker=None):
   439                                                   results = self.blob_service.list_containers(prefix=prefix,
   440                                                                                               num_results=limit,
   441                                                                                               marker=marker)
   442                                                   return (results.items, results.next_marker)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: create_container at line 444

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   444                                               @profile
   445                                               def create_container(self, container_name):
   446                                                   try:
   447                                                       self.blob_service.create_container(container_name,
   448                                                                                          fail_on_exist=True)
   449                                                   except AzureConflictHttpError as cloud_error:
   450                                                       if cloud_error.error_code == "ContainerAlreadyExists":
   451                                                           msg = "The given Bucket name '%s' already exists. Please " \
   452                                                                 "use the `get` or `find` method to get a reference to " \
   453                                                                 "an existing Bucket, or specify a new Bucket name to " \
   454                                                                 "create.\nNote that in Azure, Buckets are contained " \
   455                                                                 "in Storage Accounts." % container_name
   456                                                           raise DuplicateResourceException(msg)
   457                                           
   458                                                   return self.blob_service.get_container_properties(container_name)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: get_container at line 460

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   460                                               @profile
   461                                               def get_container(self, container_name):
   462                                                   return self.blob_service.get_container_properties(container_name)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: delete_container at line 464

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   464                                               @profile
   465                                               def delete_container(self, container_name):
   466                                                   self.blob_service.delete_container(container_name)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: list_blobs at line 468

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   468                                               @profile
   469                                               def list_blobs(self, container_name, prefix=None):
   470                                                   return self.blob_service.list_blobs(container_name, prefix=prefix)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: get_blob at line 472

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   472                                               @profile
   473                                               def get_blob(self, container_name, blob_name):
   474                                                   return self.blob_service.get_blob_properties(container_name, blob_name)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: create_blob_from_text at line 476

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   476                                               @profile
   477                                               def create_blob_from_text(self, container_name, blob_name, text):
   478                                                   self.blob_service.create_blob_from_text(container_name,
   479                                                                                           blob_name, text)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: create_blob_from_file at line 481

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   481                                               @profile
   482                                               def create_blob_from_file(self, container_name, blob_name, file_path):
   483                                                   self.blob_service.create_blob_from_path(container_name,
   484                                                                                           blob_name, file_path)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: delete_blob at line 486

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   486                                               @profile
   487                                               def delete_blob(self, container_name, blob_name):
   488                                                   self.blob_service.delete_blob(container_name, blob_name)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: get_blob_url at line 490

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   490                                               @profile
   491                                               def get_blob_url(self, container_name, blob_name, expiry_time):
   492                                                   expiry_date = datetime.datetime.utcnow() + datetime.timedelta(
   493                                                       seconds=expiry_time)
   494                                                   sas = self.blob_service.generate_blob_shared_access_signature(
   495                                                       container_name, blob_name, permission=BlobPermissions.READ,
   496                                                       expiry=expiry_date)
   497                                                   return self.blob_service.make_blob_url(container_name, blob_name,
   498                                                                                          sas_token=sas)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: get_blob_content at line 500

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   500                                               @profile
   501                                               def get_blob_content(self, container_name, blob_name):
   502                                                   out_stream = BytesIO()
   503                                                   self.blob_service.get_blob_to_stream(container_name,
   504                                                                                        blob_name, out_stream)
   505                                                   return out_stream

Total time: 154.785 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: create_empty_disk at line 507

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   507                                               @profile
   508                                               def create_empty_disk(self, disk_name, params):
   509         5      22114.0   4422.8      0.0          return self.compute_client.disks.create_or_update(
   510         5         42.0      8.4      0.0              self.resource_group,
   511         5          4.0      0.8      0.0              disk_name,
   512         5  154763184.0 30952636.8    100.0              params
   513                                                   ).result()

Total time: 61.8265 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: create_snapshot_disk at line 515

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   515                                               @profile
   516                                               def create_snapshot_disk(self, disk_name, params):
   517         2        937.0    468.5      0.0          return self.compute_client.disks.create_or_update(
   518         2         16.0      8.0      0.0              self.resource_group,
   519         2          0.0      0.0      0.0              disk_name,
   520         2   61825555.0 30912777.5    100.0              params
   521                                                   ).result()

Total time: 13.0483 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: get_disk at line 523

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   523                                               @profile
   524                                               def get_disk(self, disk_id):
   525        54        331.0      6.1      0.0          url_params = azure_helpers.parse_url(VOLUME_RESOURCE_ID,
   526        54       2974.0     55.1      0.0                                               disk_id)
   527        54        192.0      3.6      0.0          disk_name = url_params.get(VOLUME_NAME)
   528        54   13044845.0 241571.2    100.0          return self.compute_client.disks.get(self.resource_group, disk_name)

Total time: 0.003016 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: list_disks at line 530

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   530                                               @profile
   531                                               def list_disks(self):
   532         6       2752.0    458.7     91.2          return self.compute_client.disks. \
   533         6        264.0     44.0      8.8              list_by_resource_group(self.resource_group)

Total time: 275.18 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: delete_disk at line 535

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   535                                               @profile
   536                                               def delete_disk(self, disk_id):
   537         9         33.0      3.7      0.0          url_params = azure_helpers.parse_url(VOLUME_RESOURCE_ID,
   538         9        272.0     30.2      0.0                                               disk_id)
   539         9         11.0      1.2      0.0          disk_name = url_params.get(VOLUME_NAME)
   540         9  275180033.0 30575559.2    100.0          self.compute_client.disks.delete(self.resource_group, disk_name).wait()

Total time: 1.28909 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: update_disk_tags at line 542

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   542                                               @profile
   543                                               def update_disk_tags(self, disk_id, tags):
   544         4         13.0      3.2      0.0          url_params = azure_helpers.parse_url(VOLUME_RESOURCE_ID,
   545         4        117.0     29.2      0.0                                               disk_id)
   546         4          7.0      1.8      0.0          disk_name = url_params.get(VOLUME_NAME)
   547         4       1914.0    478.5      0.1          return self.compute_client.disks.update(
   548         4         30.0      7.5      0.0              self.resource_group,
   549         4          1.0      0.2      0.0              disk_name,
   550         4          3.0      0.8      0.0              {'tags': tags},
   551         4    1287000.0 321750.0     99.8              raw=True
   552                                                   )

Total time: 0.006221 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: list_snapshots at line 554

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   554                                               @profile
   555                                               def list_snapshots(self):
   556        12       5710.0    475.8     91.8          return self.compute_client.snapshots. \
   557        12        511.0     42.6      8.2              list_by_resource_group(self.resource_group)

Total time: 2.48516 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: get_snapshot at line 559

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   559                                               @profile
   560                                               def get_snapshot(self, snapshot_id):
   561        12         53.0      4.4      0.0          url_params = azure_helpers.parse_url(SNAPSHOT_RESOURCE_ID,
   562        12        622.0     51.8      0.0                                               snapshot_id)
   563        12         30.0      2.5      0.0          snapshot_name = url_params.get(SNAPSHOT_NAME)
   564        12       7012.0    584.3      0.3          return self.compute_client.snapshots.get(self.resource_group,
   565        12    2477439.0 206453.2     99.7                                                   snapshot_name)

Total time: 93.2656 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: create_snapshot at line 567

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   567                                               @profile
   568                                               def create_snapshot(self, snapshot_name, params):
   569         3       1486.0    495.3      0.0          return self.compute_client.snapshots.create_or_update(
   570         3         25.0      8.3      0.0              self.resource_group,
   571         3          1.0      0.3      0.0              snapshot_name,
   572         3   93264095.0 31088031.7    100.0              params
   573                                                   ).result()

Total time: 91.916 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: delete_snapshot at line 575

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   575                                               @profile
   576                                               def delete_snapshot(self, snapshot_id):
   577         3         11.0      3.7      0.0          url_params = azure_helpers.parse_url(SNAPSHOT_RESOURCE_ID,
   578         3         99.0     33.0      0.0                                               snapshot_id)
   579         3          6.0      2.0      0.0          snapshot_name = url_params.get(SNAPSHOT_NAME)
   580         3       1506.0    502.0      0.0          self.compute_client.snapshots.delete(self.resource_group,
   581         3   91914390.0 30638130.0    100.0                                               snapshot_name).wait()

Total time: 3.81265 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: update_snapshot_tags at line 583

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   583                                               @profile
   584                                               def update_snapshot_tags(self, snapshot_id, tags):
   585         8         24.0      3.0      0.0          url_params = azure_helpers.parse_url(SNAPSHOT_RESOURCE_ID,
   586         8        242.0     30.2      0.0                                               snapshot_id)
   587         8          9.0      1.1      0.0          snapshot_name = url_params.get(SNAPSHOT_NAME)
   588         8       3725.0    465.6      0.1          return self.compute_client.snapshots.update(
   589         8         66.0      8.2      0.0              self.resource_group,
   590         8          5.0      0.6      0.0              snapshot_name,
   591         8          7.0      0.9      0.0              {'tags': tags},
   592         8    3808572.0 476071.5     99.9              raw=True
   593                                                   )

Total time: 5e-05 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: is_gallery_image at line 595

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   595                                               @profile
   596                                               def is_gallery_image(self, image_id):
   597         2          2.0      1.0      4.0          url_params = azure_helpers.parse_url(IMAGE_RESOURCE_ID,
   598         2         46.0     23.0     92.0                                               image_id)
   599                                                   # If it is a gallery image, it will always have an offer
   600         2          2.0      1.0      4.0          return 'offer' in url_params

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: create_image at line 602

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   602                                               @profile
   603                                               def create_image(self, name, params):
   604                                                   return self.compute_client.images. \
   605                                                       create_or_update(self.resource_group, name,
   606                                                                        params).result()

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: delete_image at line 608

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   608                                               @profile
   609                                               def delete_image(self, image_id):
   610                                                   url_params = azure_helpers.parse_url(IMAGE_RESOURCE_ID,
   611                                                                                        image_id)
   612                                                   if not self.is_gallery_image(image_id):
   613                                                       name = url_params.get(IMAGE_NAME)
   614                                                       self.compute_client.images.delete(self.resource_group, name).wait()

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: list_images at line 616

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   616                                               @profile
   617                                               def list_images(self):
   618                                                   azure_images = list(self.compute_client.images.
   619                                                                       list_by_resource_group(self.resource_group))
   620                                                   return azure_images

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: list_gallery_refs at line 622

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   622                                               @profile
   623                                               def list_gallery_refs(self):
   624                                                   return gallery_image_references

Total time: 0.000207 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: get_image at line 626

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   626                                               @profile
   627                                               def get_image(self, image_id):
   628         2          6.0      3.0      2.9          url_params = azure_helpers.parse_url(IMAGE_RESOURCE_ID,
   629         2         70.0     35.0     33.8                                               image_id)
   630         2         74.0     37.0     35.7          if self.is_gallery_image(image_id):
   631         2          2.0      1.0      1.0              return GalleryImageReference(publisher=url_params['publisher'],
   632         2          2.0      1.0      1.0                                           offer=url_params['offer'],
   633         2          1.0      0.5      0.5                                           sku=url_params['sku'],
   634         2         52.0     26.0     25.1                                           version=url_params['version'])
   635                                                   else:
   636                                                       name = url_params.get(IMAGE_NAME)
   637                                                       return self.compute_client.images.get(self.resource_group, name)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: update_image_tags at line 639

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   639                                               @profile
   640                                               def update_image_tags(self, image_id, tags):
   641                                                   url_params = azure_helpers.parse_url(IMAGE_RESOURCE_ID,
   642                                                                                        image_id)
   643                                                   if self.is_gallery_image(image_id):
   644                                                       return True
   645                                                   else:
   646                                                       name = url_params.get(IMAGE_NAME)
   647                                                       return self.compute_client.images. \
   648                                                           create_or_update(self.resource_group, name,
   649                                                                            {
   650                                                                                'tags': tags,
   651                                                                                'location': self.region_name
   652                                                                            }).result()

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: list_vm_types at line 654

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   654                                               @profile
   655                                               def list_vm_types(self):
   656                                                   return self.compute_client.virtual_machine_sizes. \
   657                                                       list(self.region_name)

Total time: 0.016803 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: list_networks at line 659

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   659                                               @profile
   660                                               def list_networks(self):
   661         2      16665.0   8332.5     99.2          return self.network_management_client.virtual_networks.list(
   662         2        138.0     69.0      0.8              self.resource_group)

Total time: 1.48537 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: get_network at line 664

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   664                                               @profile
   665                                               def get_network(self, network_id):
   666         6          6.0      1.0      0.0          url_params = azure_helpers.parse_url(NETWORK_RESOURCE_ID,
   667         6        132.0     22.0      0.0                                               network_id)
   668         6          8.0      1.3      0.0          network_name = url_params.get(NETWORK_NAME)
   669         6       4650.0    775.0      0.3          return self.network_management_client.virtual_networks.get(
   670         6    1480579.0 246763.2     99.7              self.resource_group, network_name)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: create_network at line 672

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   672                                               @profile
   673                                               def create_network(self, name, params):
   674                                                   return self.network_management_client.virtual_networks. \
   675                                                       create_or_update(self.resource_group,
   676                                                                        name,
   677                                                                        parameters=params).result()

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: delete_network at line 679

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   679                                               @profile
   680                                               def delete_network(self, network_id):
   681                                                   url_params = azure_helpers.parse_url(NETWORK_RESOURCE_ID, network_id)
   682                                                   network_name = url_params.get(NETWORK_NAME)
   683                                                   return self.network_management_client.virtual_networks. \
   684                                                       delete(self.resource_group, network_name).wait()

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: update_network_tags at line 686

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   686                                               @profile
   687                                               def update_network_tags(self, network_id, tags):
   688                                                   url_params = azure_helpers.parse_url(NETWORK_RESOURCE_ID, network_id)
   689                                                   network_name = url_params.get(NETWORK_NAME)
   690                                                   return self.network_management_client.virtual_networks. \
   691                                                       create_or_update(self.resource_group,
   692                                                                        network_name, tags).result()

Total time: 0.000282 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: get_network_id_for_subnet at line 694

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   694                                               @profile
   695                                               def get_network_id_for_subnet(self, subnet_id):
   696         6        193.0     32.2     68.4          url_params = azure_helpers.parse_url(SUBNET_RESOURCE_ID, subnet_id)
   697         6          9.0      1.5      3.2          network_id = NETWORK_RESOURCE_ID[0]
   698        30         27.0      0.9      9.6          for key, val in url_params.items():
   699        24         48.0      2.0     17.0              network_id = network_id.replace("{" + key + "}", val)
   700         6          5.0      0.8      1.8          return network_id

Total time: 0.001802 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: list_subnets at line 702

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   702                                               @profile
   703                                               def list_subnets(self, network_id):
   704         2         78.0     39.0      4.3          url_params = azure_helpers.parse_url(NETWORK_RESOURCE_ID, network_id)
   705         2          3.0      1.5      0.2          network_name = url_params.get(NETWORK_NAME)
   706         2       1599.0    799.5     88.7          return self.network_management_client.subnets. \
   707         2        122.0     61.0      6.8              list(self.resource_group, network_name)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: get_subnet at line 709

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   709                                               @profile
   710                                               def get_subnet(self, subnet_id):
   711                                                   url_params = azure_helpers.parse_url(SUBNET_RESOURCE_ID,
   712                                                                                        subnet_id)
   713                                                   network_name = url_params.get(NETWORK_NAME)
   714                                                   subnet_name = url_params.get(SUBNET_NAME)
   715                                                   return self.network_management_client.subnets. \
   716                                                       get(self.resource_group, network_name, subnet_name)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: create_subnet at line 718

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   718                                               @profile
   719                                               def create_subnet(self, network_id, subnet_name, params):
   720                                                   url_params = azure_helpers.parse_url(NETWORK_RESOURCE_ID, network_id)
   721                                                   network_name = url_params.get(NETWORK_NAME)
   722                                                   result_create = self.network_management_client \
   723                                                       .subnets.create_or_update(
   724                                                           self.resource_group,
   725                                                           network_name,
   726                                                           subnet_name,
   727                                                           params
   728                                                       )
   729                                                   subnet_info = result_create.result()
   730                                           
   731                                                   return subnet_info

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: __if_subnet_in_use at line 733

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   733                                               @profile
   734                                               def __if_subnet_in_use(e):
   735                                                   # return True if the CloudError exception is due to subnet being in use
   736                                                   if isinstance(e, CloudError):
   737                                                       if e.error.error == "InUseSubnetCannotBeDeleted":
   738                                                           return True
   739                                                   return False

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: delete_subnet at line 741

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   741                                               @tenacity.retry(stop=tenacity.stop_after_attempt(5),
   742                                                               retry=tenacity.retry_if_exception(__if_subnet_in_use),
   743                                                               wait=tenacity.wait_fixed(5),
   744                                                               reraise=True)
   745                                               @profile
   746                                               def delete_subnet(self, subnet_id):
   747                                                   url_params = azure_helpers.parse_url(SUBNET_RESOURCE_ID,
   748                                                                                        subnet_id)
   749                                                   network_name = url_params.get(NETWORK_NAME)
   750                                                   subnet_name = url_params.get(SUBNET_NAME)
   751                                           
   752                                                   try:
   753                                                       result_delete = self.network_management_client \
   754                                                           .subnets.delete(
   755                                                               self.resource_group,
   756                                                               network_name,
   757                                                               subnet_name
   758                                                           )
   759                                                       result_delete.wait()
   760                                                   except CloudError as cloud_error:
   761                                                       log.exception(cloud_error.message)
   762                                                       raise cloud_error

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: create_floating_ip at line 764

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   764                                               @profile
   765                                               def create_floating_ip(self, public_ip_name, public_ip_parameters):
   766                                                   return self.network_management_client.public_ip_addresses. \
   767                                                       create_or_update(self.resource_group,
   768                                                                        public_ip_name,
   769                                                                        public_ip_parameters).result()

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: get_floating_ip at line 771

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   771                                               @profile
   772                                               def get_floating_ip(self, public_ip_id):
   773                                                   url_params = azure_helpers.parse_url(PUBLIC_IP_RESOURCE_ID,
   774                                                                                        public_ip_id)
   775                                                   public_ip_name = url_params.get(PUBLIC_IP_NAME)
   776                                                   return self.network_management_client. \
   777                                                       public_ip_addresses.get(self.resource_group, public_ip_name)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: delete_floating_ip at line 779

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   779                                               @profile
   780                                               def delete_floating_ip(self, public_ip_id):
   781                                                   url_params = azure_helpers.parse_url(PUBLIC_IP_RESOURCE_ID,
   782                                                                                        public_ip_id)
   783                                                   public_ip_name = url_params.get(PUBLIC_IP_NAME)
   784                                                   self.network_management_client. \
   785                                                       public_ip_addresses.delete(self.resource_group,
   786                                                                                  public_ip_name).wait()

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: update_fip_tags at line 788

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   788                                               @profile
   789                                               def update_fip_tags(self, fip_id, tags):
   790                                                   url_params = azure_helpers.parse_url(PUBLIC_IP_RESOURCE_ID,
   791                                                                                        fip_id)
   792                                                   fip_name = url_params.get(PUBLIC_IP_NAME)
   793                                                   self.network_management_client.public_ip_addresses. \
   794                                                       create_or_update(self.resource_group,
   795                                                                        fip_name, tags).result()

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: list_floating_ips at line 797

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   797                                               @profile
   798                                               def list_floating_ips(self):
   799                                                   return self.network_management_client.public_ip_addresses.list(
   800                                                       self.resource_group)

Total time: 0.001097 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: list_vm at line 802

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   802                                               @profile
   803                                               def list_vm(self):
   804         2        968.0    484.0     88.2          return self.compute_client.virtual_machines.list(
   805         2        129.0     64.5     11.8              self.resource_group
   806                                                   )

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: restart_vm at line 808

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   808                                               @profile
   809                                               def restart_vm(self, vm_id):
   810                                                   url_params = azure_helpers.parse_url(VM_RESOURCE_ID,
   811                                                                                        vm_id)
   812                                                   vm_name = url_params.get(VM_NAME)
   813                                                   return self.compute_client.virtual_machines.restart(
   814                                                       self.resource_group, vm_name).wait()

Total time: 81.5978 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: delete_vm at line 816

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   816                                               @profile
   817                                               def delete_vm(self, vm_id):
   818         2          6.0      3.0      0.0          url_params = azure_helpers.parse_url(VM_RESOURCE_ID,
   819         2         56.0     28.0      0.0                                               vm_id)
   820         2          3.0      1.5      0.0          vm_name = url_params.get(VM_NAME)
   821         2        930.0    465.0      0.0          return self.compute_client.virtual_machines.delete(
   822         2   81596835.0 40798417.5    100.0              self.resource_group, vm_name).wait()

Total time: 1.73237 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: get_vm at line 824

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   824                                               @profile
   825                                               def get_vm(self, vm_id):
   826         6         29.0      4.8      0.0          url_params = azure_helpers.parse_url(VM_RESOURCE_ID,
   827         6        367.0     61.2      0.0                                               vm_id)
   828         6         13.0      2.2      0.0          vm_name = url_params.get(VM_NAME)
   829         6       3885.0    647.5      0.2          return self.compute_client.virtual_machines.get(
   830         6         62.0     10.3      0.0              self.resource_group,
   831         6          4.0      0.7      0.0              vm_name,
   832         6    1728012.0 288002.0     99.7              expand='instanceView'
   833                                                   )

Total time: 252.683 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: create_vm at line 835

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   835                                               @profile
   836                                               def create_vm(self, vm_name, params):
   837         2      15216.0   7608.0      0.0          return self.compute_client.virtual_machines. \
   838         2         16.0      8.0      0.0              create_or_update(self.resource_group,
   839         2  252667585.0 126333792.5    100.0                               vm_name, params).result()

Total time: 2.57777 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: update_vm at line 841

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   841                                               @profile
   842                                               def update_vm(self, vm_id, params):
   843         4         13.0      3.2      0.0          url_params = azure_helpers.parse_url(VM_RESOURCE_ID,
   844         4        103.0     25.8      0.0                                               vm_id)
   845         4          6.0      1.5      0.0          vm_name = url_params.get(VM_NAME)
   846         4       1852.0    463.0      0.1          return self.compute_client.virtual_machines. \
   847         4         35.0      8.8      0.0              create_or_update(self.resource_group,
   848         4    2575761.0 643940.2     99.9                               vm_name, params, raw=True)

Total time: 215.106 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: deallocate_vm at line 850

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   850                                               @profile
   851                                               def deallocate_vm(self, vm_id):
   852         2          6.0      3.0      0.0          url_params = azure_helpers.parse_url(VM_RESOURCE_ID,
   853         2         59.0     29.5      0.0                                               vm_id)
   854         2          2.0      1.0      0.0          vm_name = url_params.get(VM_NAME)
   855         2       1006.0    503.0      0.0          self.compute_client. \
   856         2         33.0     16.5      0.0              virtual_machines.deallocate(self.resource_group,
   857         2  215104764.0 107552382.0    100.0                                          vm_name).wait()

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: generalize_vm at line 859

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   859                                               @profile
   860                                               def generalize_vm(self, vm_id):
   861                                                   url_params = azure_helpers.parse_url(VM_RESOURCE_ID,
   862                                                                                        vm_id)
   863                                                   vm_name = url_params.get(VM_NAME)
   864                                                   self.compute_client.virtual_machines. \
   865                                                       generalize(self.resource_group, vm_name)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: start_vm at line 867

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   867                                               @profile
   868                                               def start_vm(self, vm_id):
   869                                                   url_params = azure_helpers.parse_url(VM_RESOURCE_ID,
   870                                                                                        vm_id)
   871                                                   vm_name = url_params.get(VM_NAME)
   872                                                   self.compute_client.virtual_machines. \
   873                                                       start(self.resource_group,
   874                                                             vm_name).wait()

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: update_vm_tags at line 876

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   876                                               @profile
   877                                               def update_vm_tags(self, vm_id, tags):
   878                                                   url_params = azure_helpers.parse_url(VM_RESOURCE_ID,
   879                                                                                        vm_id)
   880                                                   vm_name = url_params.get(VM_NAME)
   881                                                   self.compute_client.virtual_machines. \
   882                                                       create_or_update(self.resource_group,
   883                                                                        vm_name, tags).result()

Total time: 21.1995 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: delete_nic at line 885

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   885                                               @profile
   886                                               def delete_nic(self, nic_id):
   887         2          5.0      2.5      0.0          nic_params = azure_helpers.\
   888         2         53.0     26.5      0.0              parse_url(NETWORK_INTERFACE_RESOURCE_ID, nic_id)
   889         2          3.0      1.5      0.0          nic_name = nic_params.get(NETWORK_INTERFACE_NAME)
   890         2       1409.0    704.5      0.0          self.network_management_client. \
   891         2         16.0      8.0      0.0              network_interfaces.delete(self.resource_group,
   892         2   21198019.0 10599009.5    100.0                                        nic_name).wait()

Total time: 0.33701 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: get_nic at line 894

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   894                                               @profile
   895                                               def get_nic(self, nic_id):
   896         2          5.0      2.5      0.0          nic_params = azure_helpers.\
   897         2         64.0     32.0      0.0              parse_url(NETWORK_INTERFACE_RESOURCE_ID, nic_id)
   898         2          3.0      1.5      0.0          nic_name = nic_params.get(NETWORK_INTERFACE_NAME)
   899         2       1771.0    885.5      0.5          return self.network_management_client. \
   900         2     335167.0 167583.5     99.5              network_interfaces.get(self.resource_group, nic_name)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: update_nic at line 902

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   902                                               @profile
   903                                               def update_nic(self, nic_id, params):
   904                                                   nic_params = azure_helpers.\
   905                                                       parse_url(NETWORK_INTERFACE_RESOURCE_ID, nic_id)
   906                                                   nic_name = nic_params.get(NETWORK_INTERFACE_NAME)
   907                                                   async_nic_creation = self.network_management_client. \
   908                                                       network_interfaces.create_or_update(
   909                                                           self.resource_group,
   910                                                           nic_name,
   911                                                           params
   912                                                       )
   913                                                   nic_info = async_nic_creation.result()
   914                                                   return nic_info

Total time: 62.265 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: create_nic at line 916

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   916                                               @profile
   917                                               def create_nic(self, nic_name, params):
   918         2       1463.0    731.5      0.0          return self.network_management_client. \
   919                                                       network_interfaces.create_or_update(
   920         2         16.0      8.0      0.0                  self.resource_group,
   921         2          2.0      1.0      0.0                  nic_name,
   922         2   62263484.0 31131742.0    100.0                  params
   923                                                       ).result()

Total time: 0.11157 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: create_public_key at line 925

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   925                                               @profile
   926                                               def create_public_key(self, entity):
   927         2      50381.0  25190.5     45.2          return self.table_service. \
   928         2         24.0     12.0      0.0              insert_or_replace_entity(self.public_key_storage_table_name,
   929         2      61165.0  30582.5     54.8                                       entity)

Total time: 2.3086 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: get_public_key at line 931

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   931                                               @profile
   932                                               def get_public_key(self, name):
   933         4    2143534.0 535883.5     92.9          entities = self.table_service. \
   934         4         43.0     10.8      0.0              query_entities(self.public_key_storage_table_name,
   935         4     165008.0  41252.0      7.1                             "Name eq '{0}'".format(name), num_results=1)
   936                                           
   937         4         11.0      2.8      0.0          return entities.items[0] if len(entities.items) > 0 else None

Total time: 0.398418 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: delete_public_key at line 939

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   939                                               @profile
   940                                               def delete_public_key(self, entity):
   941         2     265317.0 132658.5     66.6          self.table_service.delete_entity(self.public_key_storage_table_name,
   942         2     133101.0  66550.5     33.4                                           entity.PartitionKey, entity.RowKey)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: list_public_keys at line 944

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   944                                               @profile
   945                                               def list_public_keys(self, partition_key, limit=None, marker=None):
   946                                                   entities = self.table_service. \
   947                                                       query_entities(self.public_key_storage_table_name,
   948                                                                      "PartitionKey eq '{0}'".format(partition_key),
   949                                                                      marker=marker, num_results=limit)
   950                                                   return (entities.items, entities.next_marker)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: delete_route_table at line 952

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   952                                               @profile
   953                                               def delete_route_table(self, route_table_name):
   954                                                   self.network_management_client. \
   955                                                       route_tables.delete(self.resource_group, route_table_name
   956                                                                           ).wait()

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: attach_subnet_to_route_table at line 958

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   958                                               @profile
   959                                               def attach_subnet_to_route_table(self, subnet_id, route_table_id):
   960                                                   url_params = azure_helpers.parse_url(SUBNET_RESOURCE_ID,
   961                                                                                        subnet_id)
   962                                                   network_name = url_params.get(NETWORK_NAME)
   963                                                   subnet_name = url_params.get(SUBNET_NAME)
   964                                           
   965                                                   subnet_info = self.network_management_client.subnets.get(
   966                                                       self.resource_group,
   967                                                       network_name,
   968                                                       subnet_name
   969                                                   )
   970                                                   if subnet_info:
   971                                                       subnet_info.route_table = {
   972                                                           'id': route_table_id
   973                                                       }
   974                                           
   975                                                       result_create = self.network_management_client. \
   976                                                           subnets.create_or_update(
   977                                                            self.resource_group,
   978                                                            network_name,
   979                                                            subnet_name,
   980                                                            subnet_info)
   981                                                       subnet_info = result_create.result()
   982                                           
   983                                                   return subnet_info

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: detach_subnet_to_route_table at line 985

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
   985                                               @profile
   986                                               def detach_subnet_to_route_table(self, subnet_id, route_table_id):
   987                                                   url_params = azure_helpers.parse_url(SUBNET_RESOURCE_ID,
   988                                                                                        subnet_id)
   989                                                   network_name = url_params.get(NETWORK_NAME)
   990                                                   subnet_name = url_params.get(SUBNET_NAME)
   991                                           
   992                                                   subnet_info = self.network_management_client.subnets.get(
   993                                                       self.resource_group,
   994                                                       network_name,
   995                                                       subnet_name
   996                                                   )
   997                                           
   998                                                   if subnet_info and subnet_info.route_table.id == route_table_id:
   999                                                       subnet_info.route_table = None
  1000                                           
  1001                                                       result_create = self.network_management_client. \
  1002                                                           subnets.create_or_update(
  1003                                                            self.resource_group,
  1004                                                            network_name,
  1005                                                            subnet_name,
  1006                                                            subnet_info)
  1007                                                       subnet_info = result_create.result()
  1008                                           
  1009                                                   return subnet_info

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: list_route_tables at line 1011

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
  1011                                               @profile
  1012                                               def list_route_tables(self):
  1013                                                   return self.network_management_client. \
  1014                                                       route_tables.list(self.resource_group)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: get_route_table at line 1016

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
  1016                                               @profile
  1017                                               def get_route_table(self, router_id):
  1018                                                   url_params = azure_helpers.parse_url(ROUTER_RESOURCE_ID,
  1019                                                                                        router_id)
  1020                                                   router_name = url_params.get(ROUTER_NAME)
  1021                                                   return self.network_management_client. \
  1022                                                       route_tables.get(self.resource_group, router_name)

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: create_route_table at line 1024

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
  1024                                               @profile
  1025                                               def create_route_table(self, route_table_name, params):
  1026                                                   return self.network_management_client. \
  1027                                                       route_tables.create_or_update(
  1028                                                        self.resource_group,
  1029                                                        route_table_name, params).result()

Total time: 0 s
File: /Users/alex/Desktop/work/cb-profiled/cloudbridge/cloudbridge/cloud/providers/azure/azure_client.py
Function: update_route_table_tags at line 1031

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
  1031                                               @profile
  1032                                               def update_route_table_tags(self, route_table_name, tags):
  1033                                                   self.network_management_client.route_tables. \
  1034                                                       create_or_update(self.resource_group,
  1035                                                                        route_table_name, tags).result()

