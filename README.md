# rTorrent automated video processing

method.set_key = event.download.finished, fileprocessing, {"execute=/path/to/script/processing.sh,$d.get_data_full_path="}
method.set_key = event.download.erased, delete_resynch_files, {"execute=/path/to/script/processing_deleted.sh,$d.get_data_full_path="}
