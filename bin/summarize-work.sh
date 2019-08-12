#!/bin/bash
#----------------------------------------------------------------------------------------
#   This was originally built to do a big merge from trunk.
#   It'll need editing for a future merge!!!
#----------------------------------------------------------------------------------------

. ~/bin/common-functions.sh

chubFileNames="pom.xml \
src/main/java/com/ca/domain/aggregator/AggregatorLeadApplicant.java \
src/main/java/com/ca/domain/caccore/ApplicationProgramRole.java \
src/main/java/com/ca/domain/caccore/CarLotRole.java \
src/main/java/com/ca/domain/common/ApplicantInfoForLexisNexisWO.java \
src/main/java/com/ca/domain/creditrisk/BureauInquiry.java \
src/main/java/com/ca/domain/creditrisk/BureauResponse.java \
src/main/java/com/ca/domain/creditrisk/RiskViewInquiry.java \
src/main/java/com/ca/domain/creditrisk/RiskViewResponse.java \
src/main/java/com/ca/domain/dealertrack/ApplicantDemographics.java \
src/main/java/com/ca/domain/dealertrack/ApplicantRequest.java \
src/main/java/com/ca/domain/dealertrack/BaseData.java \
src/main/java/com/ca/domain/riskadmin/BureauPullAttributeType.java \
src/main/java/com/ca/domain/riskadmin/FormulaFunction.java \
src/main/java/com/ca/domain/riskadmin/PricingMethod.java \
src/main/java/com/ca/domain/riskadmin/PricingPolicy.java \
src/main/java/com/ca/domain/scoring/stepsreqresp/Step4VscCaPricingRequest.java \
src/main/java/com/ca/domain/scoring/stepsreqresp/wo/VehicleOnDealWO.java \
src/main/java/com/ca/domain/steps/AddressType.java \
src/main/java/com/ca/domain/steps/Applicant.java \
src/main/java/com/ca/domain/steps/ApplicantHistory.java \
src/main/java/com/ca/domain/steps/SmartDocsRequest.java \
src/main/java/com/ca/domain/steps/StepType.java \
src/main/java/com/ca/domain/steps/VlaXmlToLss.java \
src/main/java/com/ca/domain/util/TierTaxUtil.java \
src/main/java/com/ca/domain/vehinv/Bbup.java \
src/main/java/com/ca/domain/vehinv/DmsErrorType.java \
src/main/java/com/ca/domain/vehinv/DviLoadFile.java \
src/main/java/com/ca/domain/vehinv/InventoryInterfaceVendor.java \
src/main/java/com/ca/domain/vehinv/InventoryShareCode.java \
src/main/java/com/ca/domain/vehinv/LoadFileStatusType.java \
src/main/java/com/ca/domain/vehinv/MilgClas.java \
src/main/java/com/ca/domain/vehinv/VehicleView.java \
src/main/java/com/ca/domain/vehinv/VeiWarningType.java \
src/main/resources/META-INF/persistence.xml"

trunkFileNames="src/main/java/com/ca/domain/caccore/AutopayDetail.java \
src/main/java/com/ca/domain/caccore/AutopayInquiryResponse.java \
src/main/java/com/ca/domain/caccore/CacStateRule.java \
src/main/java/com/ca/domain/caccore/CarLot.java \
src/main/java/com/ca/domain/caccore/CarLotCarletonFee.java \
src/main/java/com/ca/domain/caccore/CarletonStateFeeType.java \
src/main/java/com/ca/domain/caccore/VscCarLotEnrollment.java \
src/main/java/com/ca/domain/carletonsmartcalcs/payment/request/CarletonFeeInput.java \
src/main/java/com/ca/domain/common/StepsContext.java \
src/main/java/com/ca/domain/constants/CacRuleEnum.java \
src/main/java/com/ca/domain/constants/Caps2ApplicationNamesEnum.java \
src/main/java/com/ca/domain/constants/CarLotNationalAccountEnum.java \
src/main/java/com/ca/domain/constants/StipulationEnum.java \
src/main/java/com/ca/domain/constants/SubmitCheckListEnum.java \
src/main/java/com/ca/domain/dealertrack/VehicleData.java \
src/main/java/com/ca/domain/riskadmin/PricingMethod.java \
src/main/java/com/ca/domain/scoring/query/wo/CustomerFeeDetailsWO.java \
src/main/java/com/ca/domain/scoring/step3reqresp/Step3WorkTheDealRequest.java \
src/main/java/com/ca/domain/scoring/step3reqresp/Step3WorkTheDealResponse.java \
src/main/java/com/ca/domain/scoring/stepsreqresp/Step4VscCaPricingRequest.java \
src/main/java/com/ca/domain/scoring/stepsreqresp/Step4WorkTheDealRequestInfo.java \
src/main/java/com/ca/domain/scoring/stepsreqresp/wo/DealInformationWO.java \
src/main/java/com/ca/domain/scoring/stepsreqresp/wo/StepsGuiValidationInformationWO.java \
src/main/java/com/ca/domain/scoring/stepsreqresp/wo/VehicleOnDealWO.java \
src/main/java/com/ca/domain/steps/Applicant.java \
src/main/java/com/ca/domain/steps/ApplicantHistory.java \
src/main/java/com/ca/domain/steps/DacLineItem.java \
src/main/java/com/ca/domain/steps/DealsAtContract.java \
src/main/java/com/ca/domain/steps/DealsInWork.java \
src/main/java/com/ca/domain/steps/DiwLineItem.java \
src/main/java/com/ca/domain/steps/VehicleLoanApplication.java \
src/main/java/com/ca/domain/steps/VehicleLoanContract.java \
src/main/java/com/ca/domain/steps/VehicleOnDeal.java \
src/main/java/com/ca/domain/test/CapsDomainTestObjectFactory.java \
src/main/java/com/ca/domain/util/TierTaxUtil.java \
src/main/java/com/ca/domain/vehinv/AutoCheckInquiryResponse.java \
src/main/java/com/ca/domain/vehinv/Vehicle.java \
src/main/java/com/ca/domain/vehinv/VehicleView.java \
src/main/resources/META-INF/persistence.xml \
src/test/java/com/ca/domain/util/TierTaxUtilTest.java"

PIIBRANCH=/home/tomh/work/caps2domain-caps2_custhub
TRUNK=/home/tomh/work/caps2domain-trunk

declare -A files

for f in $trunkFileNames ;do
    files[$f]='fromTrunk'
done

for f in $chubFileNames ;do
    if [[ ${files[$f]} == 'fromTrunk' ]] ;then
        files[$f]='both'
    else
        files[$f]='chub'
    fi
done

trunkCount=0
chubCount=0
bothCount=0
for f in ${!files[@]} ;do
    if [[ ${files[$f]} == 'fromTrunk' ]] ;then
        trunkCount=$(expr $trunkCount + 1)
    elif [[ ${files[$f]} == 'chub' ]] ;then
        chubCount=$(expr $chubCount + 1)
    elif [[ ${files[$f]} == 'both' ]] ;then
        bothCount=$(expr $bothCount + 1)
    else
        Error "Unexpected source: ${files[$f]}"
    fi
done

echo "---------------------- fromTrunk ($trunkCount) ----------------------"
for f in ${!files[@]} ;do
    if [[ ${files[$f]} == 'fromTrunk' ]] ;then
        echo "leave alone : $f"
    fi
done

echo "---------------------- chub ($chubCount) ----------------------"
for f in ${!files[@]} ;do
    if [[ ${files[$f]} == 'chub' ]] ;then
        echo "copy from chub : $f"
    fi
done

echo "---------------------- both ($bothCount) ----------------------"
for f in ${!files[@]} ;do
    if [[ ${files[$f]} == 'both' ]] ;then
        pathName=$(dirname $f)
        baseName=$(basename $f)
        fileName=${baseName%%.*}
        extension=${f##*.}

        mergeFile=${pathName}/$fileName-merge.${extension}

        if [ -e $PIIBRANCH/$mergeFile ] ;then
            echo "Merged piibranch : $f"

        elif [ -e $TRUNK/$mergeFile ] ;then
            echo "Merged trunk : $f"

        else
            echo "NOT merged : $f"
        fi
    fi
done
