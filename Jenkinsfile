/**
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

pipeline {
  agent {
      label "terraform-exec"
  }
  stages {
    // [START tf-init, tf-validate]
    stage('TF init & validate') {
      steps {
        container('terraform') {
          sh '''
            for dir in environments/*/
            do 
              cd ${dir}
              env=${dir%*/}
              env=${env#*/}
              echo ""
              echo "*************** TERRAFOM INIT and VALIDATE ******************"
              echo "******* At environment: ${env} ********"
              echo "*************************************************"
              terraform init || exit 1
              terraform validate || exit 1
              cd ../../
            done
          '''
        }
      }
    }
    // [END tf-init, tf-validate]

    // [START tf-plan]
    stage('TF plan') {
      steps {
        container('terraform') {
          sh '''
            for dir in environments/*/
            do 
              cd ${dir}
              env=${dir%*/}
              env=${env#*/}
              echo ""
              echo "*************** TERRAFOM PLAN ******************"
              echo "******* At environment: ${env} ********"
              echo "*************************************************"
              terraform plan || exit 1
              cd ../../
            done
          '''
        }
      }
    }
    // [END tf-plan]

    // [START tf-apply]
    stage('TF Apply') {
      steps {
        container('terraform') {
          sh '''
            for dir in environments/*/
            do 
              cd ${dir}
              env=${dir%*/}
              env=${env#*/}
              echo ""
              echo "*************** TERRAFOM PLAN ******************"
              echo "******* At environment: ${env} ********"
              echo "*************************************************"
              terraform apply -input=false -auto-approve || exit 1
              cd ../../
            done
          '''
        }
      }
    }
    // [END tf-apply]
  }
}
