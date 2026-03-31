-- CreateIndex
CREATE INDEX `ReportUpdate_updatedBy_idx` ON `ReportUpdate`(`updatedBy`);

-- AddForeignKey
ALTER TABLE `ReportUpdate` ADD CONSTRAINT `ReportUpdate_updatedBy_fkey` FOREIGN KEY (`updatedBy`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
