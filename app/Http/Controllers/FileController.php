<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

use App\File;
use App\Bulk;
use App\Exercise;

use DateTime;

class FileController extends Controller
{
    public function load(Request $request)
    {
        Log::info('***** FileController ***** performing loading *****');

        $path = $request->file('file')->store('uploads', 'public');
        $ext  = $request->file('file')->extension();
        $name = $request->name;

        Log::info('name       : '.$name);
        Log::info('client path: '.$request->file('file')->path());
        Log::info('path       : '.$path);
        Log::info('client ext : '.$request->file('file')->clientExtension());
        Log::info('ext        : '.$ext);

        //TODO maybe check not save double file
        $file = new File;
        $file->ext = $ext;
        $file->filename = $name;
        $file->stor_name = $path;
        $file->save();
        $file_id = $file->id;

        if($ext == 'txt')
        {
            $raw = $request->file('file')->get();
            $raws = explode("\n", $raw); // redundant
            Log::info('count exercises : '.(count($raws) - 2));

            if(count($raws) > 1)
            {
                Log::info('length of typeline: '.strlen($raws[1]));

                $bulk = new Bulk;
                $bulk->file_id = $file_id;
                $bulk->type = $raws[0];
                $bulk->line = $raws[1];
                $bulk->save();
            }
        }

        return;
    }

    public function get(Request $request)
    {
        $files = File::all();
        $files = $files->map(function($file){
            $file->stor_name = substr($file->stor_name, 0, 20);
            unset($file->id);
            return $file;
        });
        return view('files', compact('files') );
    }

    public function clear(Request $request)
    {
        // TODO maybe delete only files
        Exercise::query()->delete();
        Bulk::query()->delete();
        File::query()->delete();
        Storage::disk('public')->deleteDirectory('uploads');

        return redirect()->route('files');
    }

    public function resolve(Request $request)
    {
        Log::info('***** FileController ***** resolving files *****');
        Exercise::query()->delete();
        $bulks = Bulk::all();

        foreach($bulks as $bulk)
        {
            if($bulk->type == "com.samsung.health.exercise")
            {
                $this->resolveExercise($bulk);
            }
        }
        Log::info('***** FileController ***** end resolving files *****');
        return redirect()->route('exercises');
    }

    // ***** resolving handlers *****

    public function resolveExercise(Bulk $bulk)
    {
        $exercise_names = ['time_offset','end_time','start_time','duration','max_speed','mean_power','max_power','mean_rpm','calorie','mean_speed','live_data','comment','distance'];
        $bulk_names  = explode(",", $bulk->line);
        $bulk_count  = count($bulk_names);
        $names       = array_flip( array_intersect( $bulk_names, $exercise_names ) );
        //TODO check that names not less

        $raw = Storage::disk('public')->get(File::find($bulk->file_id)->stor_name);
        $raws = explode("\n", $raw);

        for($i = 2; $i < count($raws); $i++)
        {
            $data = explode(",", $raws[$i]);

            //detect broken lines
            if(count($data) != $bulk_count)
                continue;

            $offset_hours = $data[$names['time_offset']] / 3600 / 1000;
            $duration_sec = $data[$names['duration']] / 1000;
            $start_time   = $data[$names['start_time']];
            $distance     = $data[$names['distance']];
            $mean_speed   = $data[$names['mean_speed']];
            $live_data    = $data[$names['live_data']];
            
            // handle time
            $dt = new DateTime($start_time);
            $dt->modify("-".round($offset_hours)." hour");
            $start_time = $dt->format('Y-m-d H:i:s');
            
            // handle blob
            $stor_name_file = File::where('filename', $live_data)->first()->stor_name;
            $live_data_blob = Storage::disk('public')->get($stor_name_file);
            
            //TODO change to mass DB saving (very slow)
            $exercise = new Exercise;
            $exercise->id = $i - 1;
            $exercise->bulk_id = $bulk->id;
            $exercise->start_time = $start_time;
            $exercise->duration = $duration_sec;
            $exercise->distance = $distance;
            $exercise->mean_speed = $mean_speed;
            $exercise->live_data = $live_data_blob;
            $exercise->save();
        }
    }
}
